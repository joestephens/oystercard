require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end
  end
  
  describe '#top_up' do
    it 'allows for topping up 10 onto card' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "doesn't allow topping up above its limit" do
      max_limit = described_class::LIMIT
      subject.top_up(max_limit)
      expect{subject.top_up(1)}.to raise_error(RuntimeError,"Card is at its limit of #{max_limit}.")
    end
  end
end
