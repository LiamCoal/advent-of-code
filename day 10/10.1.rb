code = ([0] + File.read('10.txt').lines.map { |l| l.to_i }).sort
code << code.last + 3

puts "1 #{@d1 = code.filter { |l| code[code.index(l) - 1] == l - 1}.count}"
puts "3 #{@d3 = code.filter { |l| code[code.index(l) - 1] == l - 3}.count}"
puts @d1 * @d3

