@code = File.read('9.txt').lines.map { |l| l.chomp.to_i }

PREAMBLE_SIZE = 25

def get_invalid
  @code.each_index do |i|
    next if i < PREAMBLE_SIZE
    preamble = @code[(i-PREAMBLE_SIZE)...i]
    continue = false
    value = @code[i]
    preamble.each do |x|
      preamble.each do |y|
        continue = true if value == x + y
      end
    end
    puts "#{value} #{preamble} #{continue}"
    return value unless continue
  end
end

count = 2
number = get_invalid
loop do
  print "try with count: #{count}"
  @code.each_index do |i|
    data = @code[i...(i+count)]
    if data.sum == number
      low = data.sort.first
      high = data.sort.last
      print " #{data}, sum = #{low + high}\n"
      exit
    end
  end
  print " [fail]\n"
  count += 1
end
