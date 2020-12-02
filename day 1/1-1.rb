code = File.read("1.txt").lines.map { |a| a.to_i }

code.each do |a|
  code.each do |b|
    if a + b == 2020
      puts "#{a} + #{b} = 2020"
      puts "#{a} * #{b} = #{a * b}"
      exit 0
    end
  end
end
