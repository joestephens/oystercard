class Journey

  attr_reader :entry_station, :exit_station, :journeys

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @journeys = {}
    @journeys[:entry_station] = entry_station
  end

  def finish(exit_station=nil)
    @exit_station = exit_station
  end

  def in_journey?
    !!@entry_station
  end

end
