
left = []
right =[]

File.open("input.txt", "r").each do |line|
    values = line.split(" ")
    left << values[0].to_i
    right << values[1].to_i
end

left.sort!
right.sort!

puts (left.zip(right).map do |a|
    a.reduce(:-).abs
end.reduce(:+))