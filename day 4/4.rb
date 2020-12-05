lines = File.read('4.txt').lines.map { |l| l.chomp }

index = 0
array = [{}]

lines.each do |line|
  if line.empty?
    index += 1
    array << {}
  else
    line.split(' ').map { |p| p.split ':' }.each do |data|
      array[index][data[0]] = data[1]
    end
  end
end

p array

def validate_byr(data); data.to_i <= 2002 and data.to_i >= 1920; end
def validate_iyr(data); data.to_i <= 2020 and data.to_i >= 2010; end
def validate_eyr(data); data.to_i <= 2030 and data.to_i >= 2020; end
def validate_hgt(data)
  i = data[0..(data.length-2)].to_i
  if data.end_with? 'cm'
    i <= 193 and i >= 150
  elsif data.end_with? 'in'
    i <= 76 and i >= 59
  else
    false
  end
end
def validate_hcl(data); data.match? /^#([0-9a-f]){6}$/; end
def validate_ecl(data); data.match? /^(amb|blu|brn|gry|grn|hzl|oth)$/; end
def validate_pid(data); data.match? /^\d{9}$/; end

ok = 0
array.each do |passport|
  next unless passport.include? 'byr'
  next unless passport.include? 'iyr'
  next unless passport.include? 'eyr'
  next unless passport.include? 'hgt'
  next unless passport.include? 'hcl'
  next unless passport.include? 'ecl'
  next unless passport.include? 'pid'
  # Ignore all 'cid'
  #
  # next unless passport.include? 'cid'
  ok += 1
end

puts ok

ok = 0
array.each do |passport|
  #puts

  next unless passport.include? 'byr'
  #puts "byr #{passport['byr']} #{validate_byr passport['byr']}"
  next unless validate_byr passport['byr']

  next unless passport.include? 'iyr'
  #puts "iyr #{passport['iyr']} #{validate_iyr passport['iyr']}"
  next unless validate_iyr passport['iyr']

  next unless passport.include? 'eyr'
  #puts "eyr #{passport['eyr']} #{validate_eyr passport['eyr']}"
  next unless validate_eyr passport['eyr']

  next unless passport.include? 'hgt'
  #puts "hgt #{passport['hgt']} #{validate_hgt passport['hgt']}"
  next unless validate_hgt passport['hgt']

  next unless passport.include? 'hcl'
  #puts "hcl #{passport['hcl']} #{validate_hcl passport['hcl']}"
  next unless validate_hcl passport['hcl']

  next unless passport.include? 'ecl'
  #puts "ecl #{passport['ecl']} #{validate_ecl passport['ecl']}"
  next unless validate_ecl passport['ecl']

  next unless passport.include? 'pid'
  #puts "pid #{passport['pid']} #{validate_pid passport['pid']}"
  next unless validate_pid passport['pid']
  # Ignore all 'cid'
  #
  # next unless passport.include? 'cid'
  ok += 1
end

puts ok
