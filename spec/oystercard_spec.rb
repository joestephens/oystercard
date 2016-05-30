require 'oystercard'

describe Oystercard do

  let(:station) { double(:station) }
  let(:min_fare) { described_class::MIN_FARE }

  describe '#initialize' do
    it 'is initially not in use' do
      expect(subject).not_to be_in_journey
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
      expect{subject.top_up(1)}.to raise_error(RuntimeError,"Card is at its limit of #{max_limit}.")
    end
  end

  describe '#deduct' do
    it 'allows for deduction of money' do
      subject.top_up(50)
      expect{subject.deduct(3)}.to change{subject.balance}.by -3
    end
  end

  describe '#touch_in' do
    it 'changes card to in-use' do
      subject.top_up(min_fare)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'raises error if balance is less than minimum fare' do
      subject.top_up(min_fare - 1)
      expect{subject.touch_in(station)}.to raise_error(RuntimeError, "Balance is below minimum fare.")
    end

    it 'remembers the entry station last used' do
      subject.top_up(min_fare)
      subject.touch_in(station)
      expect(subject.stations.last).to eq station
    end
  end

  describe '#touch_out' do
    it 'changes card to no longer in-use' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'forgets last entry station that was used' do
      subject.top_up(min_fare)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.stations.last).to be_nil 
    end
  end
end
