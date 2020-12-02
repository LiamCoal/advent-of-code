code = File.read("2.txt").lines

regex = /^(?<min>\d+)-(?<max>\d+) (?<char>.): (?<psk>.*)$/
password_count = 0
code.each do |line|
  match = regex.match line
  return if match.nil?
  min = match.named_captures['min'].to_i - 1
  max = match.named_captures['max'].to_i - 1
  chr = match.named_captures['char']
  psk = match.named_captures['psk']

  count = 0
  psk.each_char do |c|
    count += 1 if c == chr
  end

  password_count += 1 if count >= min and count <= max

  puts "#{min} #{max} #{chr} #{psk} #{count >= min and count <= max}"
end

p password_count
