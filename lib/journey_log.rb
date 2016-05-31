class JourneyLog
  attr_reader :journeys, :journey

  def initialize(journey = Journey.new)
    @journeys = []
    @journey = journey
  end

  def start(station)
    @journeys << @journey.finish(nil) if in_journey?
    @journey = Journey.new(station)
  end

  def finish(station)
    return @journeys << @journey.finish(station) if in_journey?
    @journey = Journey.new(nil)
    @journeys << @journey.finish(station)
  end

  def in_journey?
    @journey.in_journey?
  end

  #What is current_journey for??
  def current_journey
    in_journey? ? @journey : @journey = Journey.new
  end
end
