require 'journey'

describe Journey do

  let(:station) { double 'station' }
  let(:station_2) { double 'station_2' }
  let(:journey) { Journey.new(station) }

  describe '#in_journey?' do
    it 'checks if the current_journey is complete' do
      expect(journey.in_journey?).to be true
      journey.exit_station = station
      expect(journey.in_journey?).to be false
    end
  end

  describe '#fare' do
    it 'returns PENALTY_FARE if there is no entry station' do
      journey.exit_station = station_2
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns MINIMUM_FARE if there is an entry station' do
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
  end

end
