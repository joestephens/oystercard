require 'oystercard'

describe Oystercard do

  let(:station) { double(:station) }
  let(:exit_station) { double(:exit_station) }
  let(:min_fare) { described_class::MIN_FARE }
  let(:journey) { {:entry => station, :exit => exit_station} }

  describe '#initialize' do
    it 'is initially not in use' do
      expect(subject).not_to be_in_journey
    end

    it 'has an empty journey log' do
      expect(subject.journey_log).to be_empty
    end
  end

  describe '#balance' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it "allows for topping up and doesn't allow topping up above its limit" do
      max_limit = described_class::LIMIT
      subject.top_up(max_limit)
      expect{ subject.top_up(1) }.to raise_error(RuntimeError, "Card is at its limit of #{max_limit}.")
    end
  end

  describe '#touch_in' do
    it 'raises error if balance is less than minimum fare' do
      subject.top_up(min_fare - 1)
      expect{ subject.touch_in(station) }.to raise_error(RuntimeError, "Balance is below minimum fare.")
    end

    it 'creates one journey when touching in and out' do
      subject.top_up(min_fare)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journey_log.last).to include(journey)
    end
  end

  describe '#touch_out' do
    it 'deducts fare from balance' do
      expect{ subject.touch_out(exit_station) }.to change{subject.balance}.by(-min_fare)
    end
  end

end
