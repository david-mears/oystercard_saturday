class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end

end

# File.open("zonelist", 'r').each do |line|
#   name, zone = line.split(',')
#   new_station = Station.new(name,)
#   all_stations = []
#   all_stations.push(new_station)
# end
#
# puts all_stations
