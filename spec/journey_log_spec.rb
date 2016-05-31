require 'journey_log'

describe JourneyLog do

  let(:station1) { double(:station1) }
  let(:station2) { double(:station2) }

  let(:journey) { double(:journey, start: nil, finish: nil, in_journey?: false, new: nil) }
  subject(:log) { described_class.new(journey) }

  it 'starts a journey' do
    expect(log).to respond_to(:start)
  end

  it 'finishes journey' do
    expect(log).to respond_to(:finish)
  end

  it 'records a journey' do
    log.start(station1)
    log.finish(station2)
    expect(log.journeys.last.exit_station).to eq station2
  end

end
