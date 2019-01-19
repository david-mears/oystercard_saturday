require 'oystercard'

RSpec.describe OysterCard do
  let(:oystercard) { OysterCard.new }
  let(:station) { double 'station' }
  let(:station_2) { double 'station_2' }

  it "initializes with balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it 'stores the journey history' do
    oystercard.top_up(10)
    oystercard.touch_in(station)
    oystercard.touch_out(station_2)
    oystercard.touch_in(station_2)
    oystercard.touch_out(station)

    expected_penultimate_journey = { in: station, out: station_2 }
    expected_last_journey = { in: station_2, out: station }
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
        expect(oystercard.journeys[-1].current_journey[:in]).to eq(station)
      end
    end

    describe '#touch_out' do

      it "deducts the fare" do
        expect{ oystercard.touch_out(station) }.to change{ oystercard.balance }.by(-Journey::PENALTY_FARE)
      end

      it "stores the last journey in @journeys" do
        oystercard.touch_out(station_2)
        expect(oystercard.journeys[-1].current_journey[:out]).to eq station_2
      end

    end

    context 'user forgets to touch_out' do

      it 'stores the entry_station in a new journey' do
        expected_penultimate_journey = { in: station }
        expected_last_journey = { in: station_2 }

        oystercard.touch_in(station)
        oystercard.touch_in(station_2)

        expect(oystercard.journeys[-1].current_journey).to eq expected_last_journey
        expect(oystercard.journeys[-2].current_journey).to eq expected_penultimate_journey
      end
    end

    context 'user forgets to touch_in' do

      it 'stores the exit_station in a new journey' do
        expected_penultimate_journey = { in: station_2, out: station }
        expected_last_journey = { in: nil, out: station_2 }

        oystercard.touch_in(station_2)
        oystercard.touch_out(station)
        oystercard.touch_out(station_2)

        expect(oystercard.journeys[-1].current_journey).to eq expected_last_journey
        expect(oystercard.journeys[-2].current_journey).to eq expected_penultimate_journey
      end

      it "deducts the penalty fare if the entry station is missed" do
        oystercard.touch_in(station_2)
        oystercard.touch_out(station)

        expect{ oystercard.touch_out(station_2) }.to change{ oystercard.balance }.by(-Journey::PENALTY_FARE)
      end
    end

end
