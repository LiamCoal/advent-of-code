@code = File.read('11.txt').lines.map { |l| l.chomp.split '' }

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

loop do
  lastcount = count
  types.each_index do |i|
    types[i].each_index do |j|
      adj = []

      adj << types[i-1][j-1].dup unless i-1 < 0 or j-1 < 0
      adj << types[i-1][j].dup unless i-1 < 0
      adj << types[i-1][j+1].dup unless i-1 < 0 or j+1 > types[0].length-1
      adj << types[i][j-1].dup unless j-1 < 0
      adj << types[i][j+1].dup unless j+1 > types[0].length-1
      adj << types[i+1][j-1].dup unless i+1 > types.length-1 or j-1 < 0
      adj << types[i+1][j].dup unless i+1 > types.length-1
      adj << types[i+1][j+1].dup unless i+1 > types.length-1 or j+1 > types[0].length-1

      # puts "#{i} #{j} #{types[i][j].inspect} = #{adj.count(:occupied)} #{adj}"
      adj = adj.map do |a|
        if a.nil?
          :floor
        else
          a
        end
      end

      if adj.count(:occupied) == 0 and types[i][j] == :chair
        newtypes[i][j] = :occupied
        # puts "#{i} #{j} = #{newtypes[i][j].inspect}"
      end

      if adj.count(:occupied) >= 4 and types[i][j] == :occupied
        newtypes[i][j] = :chair
        # puts "#{i} #{j} = #{newtypes[i][j].inspect}"
      end
    end
  end
  count = 0
  newtypes.each do |t|
    count += t.count :occupied
  end
  puts "iteration #{iter}, lastCount=#{lastcount}, count=#{count}"
  puts to_code newtypes
  p newtypes
  break if types == newtypes
  types = newtypes.map(&:dup)
  iter += 1
end

p count
