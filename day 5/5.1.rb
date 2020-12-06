def into_bin(str)
  str.tr('FBLR', '0101')
end

max = 0

File.read('5.txt').each_line do |line|
  if into_bin(line).to_i(2) > max
    max = into_bin(line).to_i(2)
  end
end

puts max
