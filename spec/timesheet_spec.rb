require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Timeclock
  describe Timesheet do

    let(:test_project_metadata) do
      {
        name:   "Villainous Timesheet",
        client: "Villainous Industries"
      }
    end

    describe '#initialize' do
      it 'records some metadata along with the project' do
        timesheet = Timesheet.new test_project_metadata

        timesheet.name.should   == 'Villainous Timesheet'
        timesheet.client.should == 'Villainous Industries'
      end
    end

    describe '#clock_in' do
      before :all do
        @timesheet = Timesheet.new test_project_metadata
      end

      it 'should record an open entry on first clock in' do
        time = nil
        Timecop.freeze(Time.now + 3600) do
          time = Time.now
          @timesheet.clock_in
        end

        @timesheet.hours.should == [
          {
            in: time
          }
        ]
      end

      it 'should raise an error on a second clock in without clock out' do
        (->{ @timesheet.clock_in }).should raise_error
      end
    end

    describe '#clock_out' do
      before :each do
        @timesheet = Timesheet.new test_project_metadata
      end

      it 'should record the time when I clock out after clocking in' do
        time_in = nil
        time_out = nil
        Timecop.freeze(Time.now + 1.hour) do
          time_in = Time.now
          @timesheet.clock_in
        end

        Timecop.freeze(Time.now + 2.hours) do
          time_out = Time.now
          @timesheet.clock_out
        end

        @timesheet.hours.last.should == {
          in:  time_in,
          out: time_out
        }

      end

      it 'should record notes on clock out if I leave some' do
        time_in = nil
        time_out = nil
        Timecop.freeze(Time.now + 3.hours) do
          time_in = Time.now
          @timesheet.clock_in
        end

        Timecop.freeze(Time.now + 4.hours) do
          time_out = Time.now
          @timesheet.clock_out note: 'This is a note'
        end

        @timesheet.hours.last.should == {
          in:   time_in,
          out:  time_out,
          note: 'This is a note'
        }

      end

      it 'should raise an error on a second clock out without clock in' do
        (->{ @timesheet.clock_out }).should raise_error("Cannot clock out without clocking in")
        (->{ Timesheet.new.clock_out }).should raise_error("Cannot clock out without clocking in")
      end
    end

    describe '#persist!' do
    end

  end
end
