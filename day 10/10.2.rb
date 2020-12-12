code = ([0] + File.open('10.txt').readlines.map(&:strip).map(&:to_i).sort)
code << code.last + 3

PERMUTATIONS = {
  1 => 1,
  2 => 2,
  3 => 4,
  4 => 7
}

p code

diffs = (1...code.length).map do |i|
  code[i] - code[i-1]
end
seq_lengths = diffs.join('').split('3').map(&:size).select(&:positive?)
total = seq_lengths.map { |n| PERMUTATIONS[n] }.reduce(:*)

p total
