class Journey

  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  attr_reader :current_journey

  def initialize(entry_station)
    @current_journey = { in: entry_station }
  end

  def exit_station= (exit_station)
    @current_journey[:out] = exit_station
  end

  def in_journey?
    ( !!@current_journey[:in] && !@current_journey[:out] )
  end

  def fare
    return !@current_journey[:in] || !@current_journey[:out] ? PENALTY_FARE : MINIMUM_FARE
  end

end
