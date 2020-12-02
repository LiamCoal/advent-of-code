code = File.read("1.txt").lines.map { |a| a.to_i }

code.each do |a|
  code.each do |b|
    code.each do |c|
      if a + b + c == 2020
        puts "#{a} + #{b} + #{c} = 2020"
        puts "#{a} * #{b} * #{c} = #{a * b * c}"
        exit 0
      end
    end
  end
end
