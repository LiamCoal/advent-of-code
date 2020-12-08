@code = File.read('7.txt').lines.map { |l| l.chomp.gsub(/\sbag(s?)/, '') }

@bags = {}

@code.each do |l|
  spl = l.split(/\s+contain\s+/)
  # p spl
  name = spl[0]
  contains = spl[1].split(/\s*,\s+/)
  # p contains
  @bags[name.gsub(/(^\s*|\s*$)/, '')] = contains.map { |o| o.gsub(/(^\s*|\s*$|\.$)/, '') }
end

p @bags

@already_iter = []

@required_bags = []
last_count = -1

bag_count = 0

@required_bags << {i: 1, name: 'shiny gold', bags: @bags['shiny gold']}

i = 1

until last_count == @required_bags.count
  last_count = @required_bags.count
  @required_bags.each do |bg|
    # p bg
    if bg[:bags].nil?
      @required_bags -= [bg[:name]]
      next
    end
    bg[:bags].each do |bag|
      unless @required_bags.map { |h| h[:name] }.include?(bag.split(' ', 2)[1])
        @required_bags << {i: i, name: bag.split(' ', 2)[1], bags: @bags[bag.split(' ', 2)[1]]}
      end
    end
  end
  # p @required_bags
  i += 1
end

$stdout.flush

def find_by_name(name)
  @required_bags.filter { |b| b[:name] == name }
end

def lineof(name)
  @code.each do |line|
    if line.start_with? name
      return @code.index(line) + 1
    end
  end
  -1
end

def iter(bags, starting_point, index = 0)
  puts "#{". " * index}#{lineof starting_point.gsub(/^\d /, '')} => #{starting_point} #{index} [TREE]"
  return 1 if find_by_name(starting_point.gsub(/^\d /, ''))[0].nil? or find_by_name(starting_point.gsub(/^\d /, ''))[0][:bags].nil?
  count = index == 0 ? 0 : 1
  find_by_name(starting_point.gsub(/^\d /, ''))[0][:bags].each do |bag|
    num = bag.split(' ', 2)[0].to_i
    bag = bag.split(' ', 2)[1]
    count += iter(bags, bag, index + 1).to_i * num
  end
  puts "#{". " * index}#{lineof starting_point.gsub(/^\d /, '')} => #{starting_point} #{index} [INSIDE: #{count}]"
  count
end

puts "#{iter(@required_bags, 'shiny gold')} bags are shiny"
