require 'oystercard'

RSpec.describe OysterCard do
  let(:oystercard) { OysterCard.new }

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:in_journey?) }

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
          maximum_balance = OysterCard::MAXIMUM_BALANCE
          subject.top_up(maximum_balance)
          expect { subject.top_up(1) }.to raise_error "ERROR!! The Maximum balance is £#{OysterCard::MAXIMUM_BALANCE}"
      end
    end

    describe '#in_journey?' do
      it "initializes as false" do
        expect(subject.in_journey?).to eq(false)
      end
    end

    describe '#touch_in' do
      it "changes @in_journey" do
        subject.instance_variable_set(:@in_journey, false)
        subject.instance_variable_set(:@balance, OysterCard::MINIMUM_BALANCE)
        subject.touch_in("")
        expect(subject.instance_variable_get(:@in_journey)).to eq true
      end

      it "throws an error if insufficient funds" do
        subject.instance_variable_set(:@balance, 0)
        expect { subject.touch_in("") }.to raise_error "Please top up"
      end

      it "remembers the entry station" do
        subject.instance_variable_set(:@balance, OysterCard::MINIMUM_BALANCE)
        subject.touch_in("Highgate")
        expect(subject.instance_variable_get(:@origin_station)).to eq("Highgate")
      end
    end

    describe '#touch_out' do
      it "returns false" do
        expect(subject.touch_out).to eq(false)
      end

      it "changes @in_journey" do
        subject.instance_variable_set(:@in_journey, true)
        subject.touch_out
        expect(subject.instance_variable_get(:@in_journey)).to eq false
      end

      it "deducts the fare" do
        expect{ subject.touch_out }.to change{ subject.instance_variable_get(:@balance) }.by(-OysterCard::MINIMUM_FARE)
      end

      xit "displays the origin station" do
        subject.instance_variable_set(:@origin_station, "Highgate")
        expect(subject.touch_out).to eq("Highgate")
      end

    end

end
