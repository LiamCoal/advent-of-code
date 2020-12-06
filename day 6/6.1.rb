@lines = File.read('6.txt').lines.map { |l| l.chomp }
@objects = [[]]
@index = 0

@lines.each do |l|
  if l.empty?
    @index += 1
    @objects << []
  else
    l.each_char { |c| @objects[@index] << c unless @objects[@index].include? c }
  end
end

p @objects
count = 0

@objects.each do |obj|
  count += obj.count
end

p count
