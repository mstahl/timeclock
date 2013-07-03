class Timesheet

  ### Accessors ===============================================================

  attr_accessor :name   # Name of this project
  attr_accessor :client # Name of the client who commissioned this project
  attr_reader   :hours  # List of clock ins/outs for this project, in order

  ### Constructor  ============================================================

  def initialize(args = {})
    args.each do |k, v|
      self.send("#{k}=", v) if self.respond_to?(k)
    end
  end

  ### Public instance methods =================================================

  def clock_in
    @hours ||= []
    raise 'Cannot clock in twice' if not @hours.empty? and @hours.last[:out].nil?
    @hours.push({
      in: Time.now
    })
  end

  def clock_out(args = {})
    if @hours.nil? or @hours.empty? or not @hours.last[:out].nil?
      raise "Cannot clock out without clocking in"
    end
    @hours.last[:out] = Time.now
    @hours.last[:note] = args[:note] unless args[:note].nil?
  end

end
