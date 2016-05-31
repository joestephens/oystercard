require 'journey'

describe Journey do
  let(:station1) { double(:station1) }
  let(:station2) { double(:station2) }
  subject(:journey) { described_class.new }

  it "takes an entry station" do
    journey.start(station1)
    expect(journey.entry_station).to eq station1
  end

  it "exit station added to journey" do
    expect { journey.finish(station2) }
    .to change { journey.exit_station }.to(station2)
  end

  it "should return the minimum fare if journey completed" do
    journey.start(station1)
    journey.finish(station2)
    expect(journey.fare).to eq 1
  end

  it "should return the penalty fare if journey incomplete" do
    journey.start(station1)
    expect(journey.fare).to eq 6
  end

  it "should return fare of 0 if journey not started" do
    expect(journey.fare).to eq 0
  end

end
