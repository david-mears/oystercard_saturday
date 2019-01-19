require_relative 'oystercard'

class JourneyLog

attr_reader :journey_list

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_list = []
  end

  def start(entry_station)
    @journey_list << @journey_class.new(entry_station)
  end

  def finish(exit_station)
    @journey_list[-1].exit_station = exit_station
  end

end
