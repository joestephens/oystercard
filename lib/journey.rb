class Journey

  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    @entry_station = station
    self
  end

  def finish(station)
    @exit_station = station
    self
  end

  def fare
    return 0 if @entry_station.nil? && @exit_station.nil?
    complete? ? zone_charge : 6
  end

  def in_journey?
    !@entry_station.nil? && @exit_station.nil?
  end

  private
    def complete?
      !@entry_station.nil? && !@exit_station.nil?
    end

    def zone_charge
      1 + (entry_station.zone - exit_station.zone).abs
    end
end
