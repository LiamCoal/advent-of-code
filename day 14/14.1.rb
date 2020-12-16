code = File.read('14.txt').lines
mask = ''
mem = []

code.each do |obj|
  case obj
  when /mask = (.+)/
    mask = $1
  when /mem\[(\d+)\] = (\d+)/
    until mem.length > $1.to_i
      mem << 0
    end
    index = $1.to_i
    mem[index] = ("%#{mask.length}.#{mask.length}b" % $2.to_i).gsub(/ /, '0')
    mask.each_char.with_index do |c, i|
      mem[index][i] = case c
               when '1'
                 '1'
               when '0'
                 '0'
               when 'X'
                 mem[index][i]
               else
                 '?'
               end
    end
    mem[index] = mem[index].to_i(2)
  else
    puts "error! #{obj}"
    exit
  end
end

p mem.sum
