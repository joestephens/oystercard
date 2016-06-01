require 'oystercard'

describe "Feature Tests" do
  it "run feature tests" do
    station = "Waterloo"
    oystercard = Oystercard.new
    oystercard.top_up(20)
    Oystercard::MAXIMUM_BALANCE
    oystercard.touch_in(station)
    oystercard.touch_out

  end
end