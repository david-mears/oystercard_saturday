require_relative 'oystercard'

class JourneyLog

# (hint: journey_class expects an object that knows how to create Journeys. Can you think of an object that already does this?)
# ^ This could either mean OysterCard or Journey.

  def initialize(journey_class = Journey)
    @journey_class = journey_class
  end

  def start(entry_station)
    @journey_class.new(entry_station)
  end

end
