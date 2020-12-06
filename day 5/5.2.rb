def into_bin(str)
  str.tr('FBLR', '0101')
end

current = 0
last = 0

File.read('5.txt').lines.map { |l| into_bin(l).to_i(2) }.sort.each do |pass|
  last = pass
  if pass == current + 2
    puts pass - 1
    exit 1
  end
  current = pass
end
