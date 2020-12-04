bools = []

File.read("3.txt").each_line do |line|
  bools << []
  line.each_char do |c|
    bools.last << (c == '#') if c.match /[.#]/
  end
end

p bools

count = 0

index = 1
obj = bools[index][index * 3]
p obj
until obj.nil? or bools[index].nil?
  p obj
  count += 1 if obj
  index += 1
  break if bools[index].nil? or bools[index][(index * 3) % bools[index].length].nil?
  obj = bools[index][(index * 3) % bools[index].length]
end

puts count
