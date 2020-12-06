@lines = File.read('6.txt').lines.map { |l| l.chomp }
@counts = []
@groups = [[]]
@index = 0

@lines.each do |l|
  if l.empty?
    @index += 1
    @groups << []
  else
    @groups[@index] << l
  end
end

p @groups

@groups.each do |a|
  answers = []
  a.each do |b|
    b.each_char do |c|
      unless answers.include? c
        answers << c
      end
    end
  end
  answers2 = answers
  a.each do |b|
    answers2 = answers2.filter { |c| b.include? c }
  end
  p answers2
  @counts << answers2.length
end

p @counts.reduce(:+)
