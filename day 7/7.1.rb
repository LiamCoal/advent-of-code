code = File.read('7.txt').lines.map { |l| l.chomp }

bags = {}

code.each do |l|
  spl = l.split(/\s+contain\s+/)
  # p spl
  name = spl[0]
  contains = spl[1].split(/\s*,\s+/)
  # p contains
  bags[name.gsub(/(^\s*|\s*$)/, '')] = contains.map { |o| o.gsub(/(^\s*|\s*$|\.$)/, '') }
end

# p bags

count = 0

search = ['shiny gold bag']
last_count = -1

until last_count == search.count
  last_count = search.count
  bags.each do |name, bag|
    unless bag.filter { |b| search.include? b.gsub(/^\d\s/, '').gsub(/s$/, '') }.empty? or search.include?(name.gsub(/^\d\s/, '').gsub(/s$/, ''))
      search << name.gsub(/^\d\s/, '').gsub(/s$/, '')
    end
  end
  if search.include?('shiny gold bag')
    search -= ['shiny gold bag']
  end
  p search
end

puts "#{(search - ['shiny gold bag']).count} bags are shiny"