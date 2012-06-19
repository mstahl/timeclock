require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Timeclock" do
  before :each do
    @cwd = File.expand_path(File.dirname(__FILE__))
    FileUtils.mkdir_p(EXAMPLE_PROJECT_PATH)
    Dir.chdir(EXAMPLE_PROJECT_PATH)
  end
  
  describe "example project" do
    it "exists" do
      `cd #{File.dirname(__FILE__)} && ls`.should include("example_project")
    end
  end
  
  describe "TimeClock module" do
    it "should create a YAML file called .timesheet in the project directory" do
      File.exists?(path('.timesheet')).should be_false
      Timeclock.create_or_load_timesheet.should be_a(Hash)
      File.exists?(path('.timesheet')).should be_true
    end
    
    
  end
  
  after :each do
    Dir.chdir(@cwd)
    FileUtils.rm_r(EXAMPLE_PROJECT_PATH)
  end
end
