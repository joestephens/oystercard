require 'oystercard'

describe Oystercard do

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'allows for topping up 10 onto card' do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

end
