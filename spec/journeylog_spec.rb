require 'journeylog'

describe JourneyLog do
  let(:station) { double 'station' }
  let(:journey) { double 'journey' }

  it 'initializes with an empty log' do
    expect(subject.journey_list).to eq []
  end

  describe '#start' do
    it do
      subject.start(station)
      expect(subject.journey_list[-1].current_journey[:in]).to eq station
    end


  end



end
