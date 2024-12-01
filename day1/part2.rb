
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

puts (left.zip(counts).inject(0) do |acc, a|
    acc += a.reduce(:*)
end)

