require 'journeylog'

describe JourneyLog do
  let(:station) { double 'station' }
  let(:station_2) { double 'station_2' }

  it 'initializes with an empty log' do
    expect(subject.journey_list).to eq []
  end

  describe '#start' do
    it 'has the entry_station be in the last journey in journey_list' do
      subject.start(station)
      expect(subject.journey_list[-1].current_journey[:in]).to eq station
    end
  end

  describe '#finish' do
    it 'has the exit_station be in the last journey in journey_list' do
      subject.start(station)
      subject.finish(station_2)
      expected_hash = { in: station, out: station_2 }
      expect(subject.journey_list[-1].current_journey).to eq expected_hash
    end
  end



end
