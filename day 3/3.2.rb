@bools = []

File.read("3.txt").each_line do |line|
  @bools << []
  line.each_char do |c|
    @bools.last << (c == '#') if c.match /[.#]/
  end
end

p @bools

@counts = []

def iter(right, down, index)
  @counts[index] = 0
  aindex = 1
  obj = @bools[aindex * down][aindex * right]
  p obj
  until obj.nil? or @bools[aindex].nil?
    p obj
    @counts[index] += 1 if obj
    aindex += 1
    break if @bools[aindex * down].nil? or @bools[aindex * down][(aindex * right) % @bools[aindex * down].length].nil?
    obj = @bools[aindex * down][(aindex * right) % @bools[aindex].length]
  end
end

iter 1, 1, 0
iter 3, 1, 1
iter 5, 1, 2
iter 7, 1, 3
iter 1, 2, 4

p @counts
end_res = 1
@counts.each { |c| end_res *= c }
puts end_res
