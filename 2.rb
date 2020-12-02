code = File.read("2.txt").lines

regex = /^(?<min>\d+)-(?<max>\d+) (?<char>.): (?<psk>.*)$/
password_count = 0
code.each do |line|
  match = regex.match line
  return if match.nil?
  sta = match.named_captures['min'].to_i - 1
  stp = match.named_captures['max'].to_i - 1
  chr = match.named_captures['char']
  psk = match.named_captures['psk']

  allow = false
  allow = true if psk[sta] == chr and psk[stp] != chr
  allow = true if psk[sta] != chr and psk[stp] == chr

  password_count += 1 if allow

  puts "#{sta} #{stp} #{chr} #{psk} #{allow}"
end

p password_count
