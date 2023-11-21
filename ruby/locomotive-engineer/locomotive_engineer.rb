class LocomotiveEngineer
  def self.generate_list_of_wagons(*ids)
    ids
  end

  def self.fix_list_of_wagons(each_wagons_id, missing_wagons)
    # TODO - I am assuming that the third element of `each_wagons_id` will always be `1` -
    # i.e. that we don't have to check if `1` is in the other chunks.
    [1] + missing_wagons + each_wagons_id[3..] + each_wagons_id[0..1]
  end

  def self.add_missing_stops(routing, **stops)
    stops_array = []
    stops.each { |key, val|
      idx = key[5..].to_s.to_i - 1
      stops_array[idx] = val
    }
    routing[:stops] = stops_array
    routing
  end

  def self.extend_route_information(route, more_route_information)
    {**route, **more_route_information}
  end
end
