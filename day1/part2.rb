
left = []
right =[]

File.open("input.txt", "r").each do |line|
    values = line.split(" ")
    left << values[0].to_i
    right << values[1].to_i
end

left.sort!
right.sort!

counts = left.map {|value| right.count(value) }

puts (left.each_with_index.map do |value, index|
    value * counts[index]
end.to_a.reduce(:+))