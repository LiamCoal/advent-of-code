@code = File.read('11.txt').lines.map { |l| l.chomp.split '' }

DEBUG = false

def map_code
  @code.map do |c|
    c.map do |ch|
      case ch
      when '.'
        :floor
      when 'L'
        :chair
      when '#'
        :occupied
      end
    end
  end
end

def to_code(types)
  types.map do |ary|
    ary.map do |type|
      case type
      when :floor
        '.'
      when :chair
        'L'
      when :occupied
        '#'
      else
        '?'
      end
    end.reduce :+
  end.reduce { |o, l| o += "\n" + l  }
end

types = map_code
newtypes = types.map(&:dup)
count = 0
iter = 1

puts to_code types
p types

def count_occ(types, startx, starty, xadd, yadd)
  puts "=>\tocc\t#{startx}\t#{starty}\t#{xadd}\t#{yadd}" if DEBUG
  y = starty
  x = startx
  o = 0
  until x < 0 or x > types.length-1 or y < 0 or y > types.length-1 or types[y][x] != :floor
    puts "\t#{y+1}\t#{x+1}\t#{types[y][x].inspect}" if DEBUG
    if types[y][x] == :occupied
      o += 1
    end
    y += yadd
    x += xadd
  end
  puts "|<\t#{y+1}\t#{x+1}" if DEBUG
  return o if (x < 0 or x > types.length-1 or y < 0 or y > types.length-1)
  puts "<-\t#{y+1}\t#{x+1}\t#{types[y][x].inspect}" if DEBUG
  o += 1 if types[y][x] == :occupied
  o
end

loop do
  lastcount = count
  types.each_index do |i|
    types[i].each_index do |j|
      next if newtypes[i][j] == :floor
      obj = newtypes[i][j]

      occupied = 0
      occupied += count_occ(types, j, i-1, 0, -1)
      occupied += count_occ(types, j-1, i-1, -1, -1)
      occupied += count_occ(types, j-1, i, -1, 0)
      occupied += count_occ(types, j-1, i+1, -1, +1)
      occupied += count_occ(types, j, i+1, 0, +1)
      occupied += count_occ(types, j+1, i-1, +1, -1)
      occupied += count_occ(types, j+1, i, +1, 0)
      occupied += count_occ(types, j+1, i+1, +1, +1)

      puts "#{i}\t#{j}\t#{occupied} #{obj.inspect}" if DEBUG

      if occupied == 0 and obj == :chair
        obj = :occupied
      elsif occupied >= 5 and obj == :occupied
        obj = :chair
      end

      newtypes[i][j] = obj
    end
  end
  count = 0
  newtypes.each do |t|
    count += t.count :occupied
  end
  puts "iteration #{iter}, lastCount=#{lastcount}, count=#{count}"
  puts to_code newtypes if DEBUG
  p newtypes if DEBUG
  break if types == newtypes
  types = newtypes.map(&:dup)
  iter += 1
end

p count
