require 'oystercard'

describe "Feature Tests" do
  it "run feature tests" do
    entry_station = "Canary Wharf"
    exit_station = "Waterloo"
    oystercard = Oystercard.new
    oystercard.top_up(20)
    Oystercard::MAXIMUM_BALANCE
    oystercard.journeys
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    oystercard.journeys
    station = Station.new("Waterloo", 1)


  end
end