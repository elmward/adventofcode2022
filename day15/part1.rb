# frozen_string_literal: true

TARGET_ROW = 2_000_000

def main
  sensor_beacons = File.foreach('./input.txt').reduce([]) do |acc, line|
    matches = /Sensor at x=(.+), y=(.+): closest beacon is at x=(.+), y=(.+)/.match(line)
    acc << [[matches[1].to_i, matches[2].to_i], [matches[3].to_i, matches[4].to_i]]
  end

  min_x, min_y, max_x, max_y = get_extents(sensor_beacons)

  no_beacon_count = (min_x..max_x).count do |x|
    sensor_beacons.any? do |(sensor, beacon)|
      manhattan_distance(sensor, [x, TARGET_ROW]) <= manhattan_distance(sensor, beacon) && [x, TARGET_ROW] != beacon
    end
  end

  puts no_beacon_count
end

def manhattan_distance(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs
end

def get_extents(sensor_beacons)
  bounds_from_sensors = sensor_beacons.reduce([[], []]) do |acc, (sensor, beacon)|
    distance = manhattan_distance(sensor, beacon)
    min_x, max_x = sensor[0] + distance, sensor[0] - distance
    min_y, max_y = sensor[1] + distance, sensor[1] - distance
    acc[0].concat([min_x, max_x])
    acc[1].concat([min_y, max_y])
    acc
  end

  all_points = sensor_beacons.reduce([]) do |acc, (sensor, beacon)|
    acc << sensor
    acc << beacon
  end

  x_vals, y_vals = all_points.transpose
  x_vals.concat(bounds_from_sensors[0])
  y_vals.concat(bounds_from_sensors[1])
  x_vals.sort!
  y_vals.sort!
  [x_vals.first, y_vals.first, x_vals.last, y_vals.last]
end

main if __FILE__ == $PROGRAM_NAME
