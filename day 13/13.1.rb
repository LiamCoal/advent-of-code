code = File.read('13.txt').lines
time = code[0].to_i
buses = code[1].split(',').filter { |a| a.match? /\d+/ }.map { |a| a.to_i }

puts "Started"

map = []

(0..time/4).each do |i|
  buses.each do |bus|
    map << [bus*i, bus, (bus*i)-time, bus*((bus*i)-time)]
  end
end

puts "Mapped"

class Numeric
  def closer_greater(other)
    return nil unless other.is_a?(Numeric)
    return 1 if other > self
    0
  end
end

puts "Sorting"
map2 = map.sort
puts "Filtering"
map2 = map2.filter { |i| i[0] > time }

puts "Answer: #{map2.first.inspect}"
# p added_minutes
