code = File.read('9.txt').lines.map { |l| l.chomp.to_i }

PREAMBLE_SIZE = 25

code.each_index do |i|
  next if i < PREAMBLE_SIZE
  preamble = code[(i-PREAMBLE_SIZE)...i]
  continue = false
  value = code[i]
  preamble.each do |x|
    preamble.each do |y|
      continue = true if value == x + y
    end
  end
  puts "#{value} #{preamble} #{continue}"
  break unless continue
end
