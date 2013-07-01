require 'yaml'

module Timeclock
  CLOCK_USAGE = %{clock [options] (in|out|add) [project name]}
  TIMESHEET_USAGE = %{timesheet [filename|default: ./.timesheet]}
  
  def self.clock_in
    create_or_load_timesheet unless @timesheet
    @timesheet[:default] ||= []
    @timesheet[:default] << [Time.now]
    self.save_timesheet
  end
  
  def self.clock_out
    raise "No timesheet exists yet! Clock in first." unless self.timesheet_exists?
    raise "Clock in first." unless @timesheet[:default].last.count == 1
    @timesheet[:default].last << Time.now
    self.save_timesheet
  end
  
  def self.create_or_load_timesheet
    if File.file?(self.timesheet_path) then
      @timesheet = YAML.load_file(self.timesheet_path)
    else
      @timesheet = {}
      self.save_timesheet
    end
    @timesheet
  end
  
  def self.timesheet
    @timesheet
  end
  
  def self.timesheet_exists?
    File.file?(self.timesheet_path)
  end
  
  private
  
  def self.project_path
    File.absolute_path(File.join(Dir.getwd))
  end
  
  def self.save_timesheet
    File.open(self.timesheet_path, 'w') do |f|
      YAML.dump(@timesheet, f)
    end
  end
  
  def self.timesheet_path
    File.join(self.project_path, '.timesheet')
  end
  
end
