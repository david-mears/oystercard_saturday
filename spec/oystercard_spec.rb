require 'oystercard'

RSpec.describe OysterCard do
  let(:oystercard) { OysterCard.new }
  let(:station) { double 'station' }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it "initializes with balance of 0" do
      expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
      it "increases balance of card" do
          expect(subject.top_up(15)).to eq(15)
      end

      it "confirms balance is updated as expected" do
          subject.top_up(15)
          expect(subject.balance).to eq(15)
      end

      it 'raises error if new balance exceeds maximum balance' do
          subject.top_up(OysterCard::MAXIMUM_BALANCE)
          expect { subject.top_up(1) }.to raise_error "ERROR!! The Maximum balance is £#{OysterCard::MAXIMUM_BALANCE}"
      end
    end

    before do
      oystercard.top_up(OysterCard::MINIMUM_BALANCE)
      oystercard.touch_in(station)
    end


    describe '#touch_in' do

      it "throws an error if insufficient funds" do
        oystercard.instance_variable_set(:@balance, 0)
        expect { oystercard.touch_in(station) }.to raise_error "Please top up"
      end

      it "remembers the entry station" do
        expect(oystercard.entry_station).to eq(station)
      end
    end

    describe '#touch_out' do

      it "deducts the fare" do
        expect{ oystercard.touch_out(station) }.to change{ oystercard.balance }.by(-OysterCard::MINIMUM_FARE)
      end

      it "forgets the entry_station on touch_out" do
        oystercard.touch_out(station)
        expect(oystercard.entry_station).to eq nil
      end

      it "stores the last journey in @journeys" do
        station_2 = double (:station_2)
        oystercard.touch_out(station_2)
        expected_hash = { station => station_2 }
        expect(oystercard.journeys[-1]).to eq expected_hash
      end

    end

end
