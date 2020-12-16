begin
  code = File.read('14.txt').lines
  mask = ''
  mem = {}

  def overlay(original, char, string)
    index = 0
    p original
    original.each_char.with_index do |c, i|
      if c == char
        c = string[index]
        index += 1
      end
      original[i] = c
    end
    original
  end

  code.each do |obj|
    puts "#{code.index obj}\t#{obj.chomp}"
    case obj
    when /mask = (.+)/
      mask = $1
    when /mem\[(\d+)\] = (\d+)/
      original_index = $1
      value = $2.to_i
      indicies = []
      a = ("%#{mask.length}.#{mask.length}b" % original_index.to_i)
      mask.each_char.with_index do |c, j|
        a[j] = c unless c == '0'
      end
      max = 1
      count = 0
      a.each_char.with_index do |c, _|
        if c == 'X'
          max *= 2
          count += 1
        end
      end
      (0...max).to_a.map { |o| "%#{count}.#{count}b" % o }.each do |object|
        b = a.dup
        o = overlay b, 'X', object
        puts "#{count} #{object.inspect} #{o.inspect}"
        indicies << o.to_i(2)
      end
      puts "->\t#{max}\t#{indicies}"
      indicies.each do |index|
        mem[index] = value
      end
    else
      puts "error! #{obj}"
      exit
    end
  end

  p mem.values.sum
end