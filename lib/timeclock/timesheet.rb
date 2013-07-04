require 'yaml'
require 'yaml/store'

module Timeclock
  class Timesheet

    ### Accessors ===============================================================

    attr_reader   :hours  # List of clock ins/outs for this project, in order

    ### Constructor  ============================================================

    def initialize
      # TODO: Move persistence-related logic out to Timeclock::Persistence
      @store = YAML::Store.new '.timesheet'
      @store.transaction do
        @store[:hours]  ||= []
        @hours = @store[:hours]
      end
    end

    ### Public instance methods =================================================

    def clock_in
      @hours ||= []
      raise 'Cannot clock in twice' if not @hours.empty? and @hours.last[:out].nil?
      @hours.push({
        in: Time.now
      })

      # TODO: Move persistence-related logic out to Timeclock::Persistence
      persist
    end

    def clock_out(args = {})
      if @hours.nil? or @hours.empty? or not @hours.last[:out].nil?
        raise "Cannot clock out without clocking in"
      end
      @hours.last[:out] = Time.now
      @hours.last[:note] = args[:note] unless args[:note].nil?

      # TODO: Move persistence-related logic out to Timeclock::Persistence
      persist
    end

    private

    def persist
      @store.transaction do
        @store[:hours]  = @hours
      end
    end

  end
end
