code = File.read('8.txt').lines
lines = code.map { |l| {line: l, times: 0, index: code.index(l)} }

index = 0
accu = 0

last_line = 0

loop do
  line = lines[index]

  line[:times] += 1
  if line[:times] == 2
    puts "[ from #{last_line} ]  #{line} executed twice"
    break
  end

  l = line[:line]
  parts = l.split(' ')

  string = parts[0]
  number = parts[1].to_i

  index_mod = +1

  case string
  when 'nop'
    puts "#{index} noped"
  when 'jmp'
    index_mod = number
    puts "#{index} jmp #{number}, #{index} = #{index + number}"
  when 'acc'
    accu += number
    puts "#{index} acc #{number} = #{accu}"
  else
    puts "BROKEN INPUT! #{string} #{number} is invalid"
  end

  code[index] = line
  index += index_mod
  last_line = line[:index]
end

# lines.each do |line|
#   if line[:times] == 0
#     puts "#{line[:index]} never executed"
#   end
# end

puts accu
