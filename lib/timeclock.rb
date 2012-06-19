require 'yaml'

module Timeclock
  CLOCK_USAGE = %{clock [options] (in|out|add) [project name]}
  TIMESHEET_USAGE = %{timesheet [filename|default: ./.timesheet]}
  
  def self.create_or_load_timesheet
    if File.file?(self.timesheet_path) then
      @timesheet = YAML.load_file(self.timesheet_path)
    else
      @timesheet = {}
      self.save_timesheet
    end
    @timesheet
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
