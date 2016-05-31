class JourneyLog
  attr_reader :journeys, :journey

  def initialize(journey = Journey.new)
    @journeys = []
    @journey = journey
  end

  def start(station)
    @journey = Journey.new if !@journey.entry_station.nil?
    @journey.start(station)
    @journeys << @journey
  end

  def finish(station)
    if @journey.entry_station == nil
      @journey = Journey.new
      @journey.finish(station)
      @journey = Journey.new
    else
      @journey.finish(station)
      @journey = Journey.new
    end
  end

  def in_journey?
    @journey.in_journey?
  end

  private

    def current_journey
      @journey
    end
end
