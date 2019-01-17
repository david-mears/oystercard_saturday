class Journey

  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  attr_reader :x

  def initialize(entry_station)
    @x = { in: entry_station }
  end

  def exit_station= (exit_station)
    @x[:out] = exit_station
  end

  def in_journey?
    ( !!@x[:in] && !@x[:out] )
  end

  def fare
    return !@x[:in] || !@x[:out] ? PENALTY_FARE : MINIMUM_FARE
  end

end
