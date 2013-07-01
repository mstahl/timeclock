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
    
    describe "clocking in" do
      before :each do
        Timeclock.create_or_load_timesheet
        Timecop.freeze(Time.now + 30) do
          Timeclock.clock_in
          @time = Time.now
        end
      end
      
      it "should add a time clocked in to the default project" do
        Timeclock.timesheet[:default].last.count.should eq(1)
        Timeclock.timesheet[:default].last[0].should eq(@time)
      end
      
      it "should have saved the timesheet" do
        @timesheet = Timeclock.create_or_load_timesheet
        @timesheet[:default].last.count.should eq(1)
        @timesheet[:default].last[0].should eq(@time)
      end
    end
    
    describe "clocking out" do
      before :each do
        Timeclock.create_or_load_timesheet
        Timecop.freeze(Time.now + 3600) do
          Timeclock.clock_in
          @in_time = Time.now
        end
        
        Timecop.freeze(Time.now + 8 * 3600) do
          Timeclock.clock_out
          @out_time = Time.now
        end
      end
      
      it "should add a time clocked out to the default project" do
        Timeclock.timesheet[:default].last.count.should eq(2)
        Timeclock.timesheet[:default].last[0].should eq(@in_time)
        Timeclock.timesheet[:default].last[1].should eq(@out_time)
      end
      
      it "should have saved the timesheet" do
        @timesheet = Timeclock.create_or_load_timesheet
        @timesheet[:default].last[0].should eq(@in_time)
        @timesheet[:default].last[1].should eq(@out_time)
      end
      
    end
    
    describe "errors" do
      it "should raise an error on clock out without a timesheet" do
        (->{ Timeclock.clock_out }).should raise_error
      end
      
      it "should raise an error on clock out without clocking in first" do
        Timeclock.create_or_load_timesheet
        (->{ Timeclock.clock_out }).should raise_error
      end
      
    end
    
  end
  
  after :each do
    Dir.chdir(@cwd)
    FileUtils.rm_r(EXAMPLE_PROJECT_PATH)
  end
end
