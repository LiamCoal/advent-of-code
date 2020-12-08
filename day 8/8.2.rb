code = File.read('8.txt').lines
lines = code.map { |l| {line: l, times: 0, index: code.index(l)} }

def iter(instructions)
  index = 0
  last_line = 0
  loop do
    line = instructions[index]
    break if index >= instructions.length

    line[:times] += 1
    if line[:times] >= 2
      # puts "[ from #{last_line} ]  #{line} executed twice"
      return false
    end

    l = line[:line]
    parts = l.split(' ')

    string = parts[0]
    number = parts[1].to_i

    index_mod = +1

    case string
    when 'nop'
      # puts "#{index} noped"
    when 'jmp'
      index_mod = number
      # puts "#{index} jmp #{number}, #{index} = #{index + number}"
    when 'acc'
      @accu += number
      # puts "#{index} acc #{number} = #{@accu}"
    else
      # puts "BROKEN INPUT! #{string} #{number} is invalid"
    end

    instructions[index] = line
    index += index_mod
    last_line = index
  end
  true
end

jmpnop_indices = []

lines.each do |line|
  jmpnop_indices << lines.index(line) if line[:line].match?(/^(jmp|nop)/)
end

jmpnop_indices.each do |index|
  newlines = lines
  if newlines[index][:line].include? 'jmp'
    newlines[index][:line] = newlines[index][:line].gsub('jmp', 'nop')
  else
    newlines[index][:line] = newlines[index][:line].gsub('nop', 'jmp')
  end
  @accu = 0
  iter = iter newlines
  puts "#{iter}\t#{newlines}"
  # puts iter
  if iter
    puts "found solution: #{@accu}"
    $stdout.flush
    exit 0
  end
  if newlines[index][:line].include? 'jmp'
    newlines[index][:line] = newlines[index][:line].gsub('jmp', 'nop')
  else
    newlines[index][:line] = newlines[index][:line].gsub('nop', 'jmp')
  end
  newlines.each_index do |i|
    newlines[i][:times] = 0
  end
end
