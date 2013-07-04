require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Timeclock
  describe Persistence do

    describe '#create_or_load_timesheet' do
      it 'should load an existing file if there is one' do
      end

      it 'should create a blank timesheet object if no timesheet file is found' do
      end
    end

    describe '#persist' do
      it 'should write out all the fields and metadata a timesheet contains in YAML to ".timesheet"' do
      end
    end

  end
end
