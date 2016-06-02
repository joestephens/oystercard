class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

end

  def initialize(entry_station=nil)
     @entry_station = entry_station
  end