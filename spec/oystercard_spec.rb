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

    describe '#deduct' do
      it "reduces balance by specified amount" do
        subject.top_up(10)
        expect{subject.deduct(10)}.to change{subject.balance}.by(-10)
      end

      it "raises error if amount deducted is greater than balance" do
        subject.top_up(5)
        expect { subject.deduct(10) }.to raise_error "Insufficient Funds"
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
        subject.touch_in
        expect(subject.instance_variable_get(:@in_journey)).to eq true
      end

      it "returns a Boolean" do
        expect(subject.touch_in).to eq(true).or eq(false)
      end
    end
    
    describe '#touch_out' do
      it "returns a Boolean" do
        expect(subject.touch_out).to be(true).or eq(false)
      end
    end
end
