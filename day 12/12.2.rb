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

east = 0
north = 0
wp_east = 10
wp_north = 1
angle = Math.atan(wp_east / wp_north)
distance = Math.sqrt((wp_east**2) + (wp_north**2))

code.each do |c|
  case c
  when /F(\d+)/
    east += wp_east * $1.to_i
    north += wp_north * $1.to_i
  when /N(\d+)/
    wp_north += $1.to_i
  when /S(\d+)/
    wp_north -= $1.to_i
  when /E(\d+)/
    wp_east += $1.to_i
  when /W(\d+)/
    wp_east -= $1.to_i
  when /L(\d+)/
    case $1.to_i
    when 90
      wp_east1 = -wp_north
      wp_north = wp_east
      wp_east = wp_east1
    when 180
      wp_east1 = -wp_east
      wp_north = -wp_north
      wp_east = wp_east1
    when 270
      wp_east1 = wp_north
      wp_north = -wp_east
      wp_east = wp_east1
    end
  when /R(\d+)/
    case $1.to_i
    when 90
      wp_east1 = wp_north
      wp_north = -wp_east
      wp_east = wp_east1
    when 180
      wp_east1 = -wp_east
      wp_north = -wp_north
      wp_east = wp_east1
    when 270
      wp_east1 = -wp_north
      wp_north = wp_east
      wp_east = wp_east1
    end
  end
  puts "#{c} >> #{east} #{north} : #{wp_east} #{wp_north}"
end

dist = east.abs + north.abs
p dist
