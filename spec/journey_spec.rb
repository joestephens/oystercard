require 'journey'

describe Journey do
  let(:station) { double :station }
  subject(:journey) { described_class.new }
  let(:exit_station) { double :station }
  let(:entry_station) { double :station }

  describe '#initialize' do

    context 'initialized with entry station as nil if no entry station given' do
      it 'is created with entry station = nil as default' do
        expect(journey.entry_station).to eq nil
      end
    end

    context 'initialized with an entry station' do
      it 'is created with entry station equal to given station' do
        my_journey = Journey.new(station)
        expect(my_journey.entry_station).to eq station
      end

      let(:journey) { {entry_station: entry_station} }
      it 'stores entry station in journeys hash' do
        my_journey = Journey.new(entry_station)
        expect(my_journey.journeys).to include journey
      end
    end

    describe '#in journey?' do
      it 'it knows if journey is in progress' do
        oystercard.top_up(minimum_fare)
        expect { oystercard.touch_in(entry_station) }.to change{ oystercard.in_journey?}.to true
      end
    end
  end

  describe 'finish journey' do
    it 'remembers exit station' do
      journey = Journey.new(station)
      journey.finish(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end



end