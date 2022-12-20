# frozen_string_literal: true

def main
  sensor_beacons = File.foreach('./input.txt').reduce([]) do |acc, line|
    matches = /Sensor at x=(.+), y=(.+): closest beacon is at x=(.+), y=(.+)/.match(line)
    acc << [[matches[1].to_i, matches[2].to_i], [matches[3].to_i, matches[4].to_i]]
  end

  (0..4_000_000).each do |y|
    coverage = ranges_for_row(y, sensor_beacons).sort_by { |r| r.first }
    cur_range = coverage.shift
    next_range = coverage.shift
    until coverage.empty?
      while next_range && next_range.first < cur_range.last
        cur_range = cur_range.first..([cur_range.last, next_range.last].max)
        next_range = coverage.shift
      end

      if next_range && next_range.first - cur_range.last > 1
        x = cur_range.last + 1
        puts "#{(x * 4_000_000) + y}"
        return
      end
      cur_range = next_range
      next_range = coverage.shift
    end
  end
end

def manhattan_distance(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs
end

def ranges_for_row(y, sensor_beacons)
  sensor_beacons.reduce([]) do |acc, (sensor, beacon)|
    vertical_distance = (sensor[1] - y).abs
    beacon_distance = manhattan_distance(sensor, beacon)
    if beacon_distance > vertical_distance
      min_x = sensor[0] - (beacon_distance - vertical_distance)
      max_x = sensor[0] + (beacon_distance - vertical_distance)
      acc << (min_x..max_x)
    end
    acc
  end
end

main if __FILE__ == $PROGRAM_NAME
