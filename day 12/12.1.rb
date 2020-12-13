code = File.read("12.txt").lines.map { |l| l.chomp }

def dir_to_i(dir)
  case dir
  when :north
    0
  when :east
    1
  when :south
    2
  when :west
    3
  end
end

def i_to_dir(i)
  case i
  when 0
    :north
  when 1
    :east
  when 2
    :south
  when 3
    :west
  end
end

dir = :east

east = 0
north = 0

code.each do |c|
  case c
  when /F(\d+)/
    case dir
    when :north
      north += $1.to_i
    when :south
      north -= $1.to_i
    when :east
      east += $1.to_i
    when :west
      east -= $1.to_i
    end
  when /N(\d+)/
    north += $1.to_i
  when /S(\d+)/
    north -= $1.to_i
  when /E(\d+)/
    east += $1.to_i
  when /W(\d+)/
    east -= $1.to_i
  when /L(\d+)/
    dir = i_to_dir((dir_to_i(dir) - ($1.to_i / 90)) % 4)
  when /R(\d+)/
    dir = i_to_dir((dir_to_i(dir) + ($1.to_i / 90)) % 4)
  end
end

dist = east.abs + north.abs
p dist
