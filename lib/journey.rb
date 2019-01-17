class Journey

attr_reader :data

  def initialize(entry_station)
    @data = { in: entry_station }
  end

  def exit_station=(exit_station)
    @data[:out] = exit_station
  end

end
