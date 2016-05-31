require 'journey'

describe Journey do
  let(:station1) { double(:station1, zone: 1) }
  let(:station2) { double(:station2, zone: 3) }
  subject(:journey) { described_class.new(station1) }

  it "takes an entry station" do
    expect(journey.entry_station).to eq station1
  end

  it "exit station added to journey" do
    expect { journey.finish(station2) }
    .to change { journey.exit_station }.to(station2)
  end

  it "should return the correct fare when journey completed" do
    journey.finish(station2)
    expect(journey.fare).to eq 3
  end

  it "should return the penalty fare if journey incomplete" do
    expect(journey.fare).to eq 6
  end

  it "should return fare of 0 if journey not started" do
    journey = Journey.new(nil)
    expect(journey.fare).to eq 0
  end

end
