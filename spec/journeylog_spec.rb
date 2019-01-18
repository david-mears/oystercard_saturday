require 'journeylog'

describe JourneyLog do

  describe '#start' do
    subject { described_class.new.instance_variable_get(:@journey_class) }
    it { is_expected.to respond_to(:new).with(1).argument }
  end

end
