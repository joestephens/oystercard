require 'oystercard'

describe Oystercard do

  subject (:oystercard) { described_class.new }
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE }
  let(:minimum_fare) { Oystercard::MINIMUM_FARE }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  context 'when new card' do

    describe '#balance' do

      it "should have a balance at initialization" do
        expect(oystercard.balance).to eq 0
      end

    end

    describe 'initial journey status' do
      it 'has an empty list of journeys by default' do
        expect(oystercard.journeys).to be_empty
      end
    end
  end

  describe '#top_up' do

    it 'should increase the balance by the amount given' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
    end

    it "should raise error if #top_up makes balance > 90" do
      expect { oystercard.top_up(maximum_balance + 1) }.to raise_error("balance cannot exceed #{maximum_balance}")
    end

  end

  describe '#touch_in' do
    it '#oystercard.balance >= minimum balance in order to touch_in' do
      expect { oystercard.touch_in(entry_station) }.to raise_error('Balance too low to enter')
    end

    it 'oystercard.in_journey = true after #touch_in' do
      oystercard.top_up(minimum_fare)
      expect { oystercard.touch_in(entry_station) }.to change{ oystercard.in_journey?}.to true
    end

    # it "should save entry station" do
    #   oystercard.top_up(minimum_fare)
    #   expect { oystercard.touch_in(entry_station)}.to change { oystercard.entry_station }.to entry_station
    # end

    it 'should save entry station' do
      oystercard.top_up(minimum_fare)
      oystercard.touch_in(entry_station)
      expect(oystercard.current_journey[:entry_station]).to eq entry_station
    end

  end

  describe '#touch_out' do
    before(:each) do
      oystercard.top_up(minimum_fare)
      oystercard.touch_in(entry_station)
    end

    it 'oystercard.in_journey = false after #touch_out' do
      expect { oystercard.touch_out(exit_station) }.to change{ oystercard.in_journey?}.to false
    end

    it 'deducts minimum fare from balance on touch out' do
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by -minimum_fare
    end

    it "resets current journey to empty hash on touch out" do
      oystercard.touch_out(exit_station)
      expect(oystercard.current_journey).to be_empty
    end

    it 'should save exit station' do
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys.last[:exit_station]).to be exit_station
    end

    let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
    it 'saves a journey' do
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include journey
    end
  end

end
