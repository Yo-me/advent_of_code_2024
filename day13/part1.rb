require 'set'
Map = []

require 'matrix'

input = IO.readlines("input.txt")

index = 0

#a1 = adx
#b1 = bdx
#a2 = ady
#b2 = bdy


costs = []
while index < input.length
    a1, a2 = input[index].split(": ")[1].split(", ").map{|v| v.split("+")[1].to_i}
    index += 1
    b1, b2 = input[index].split(": ")[1].split(", ").map{|v| v.split("+")[1].to_i}
    index += 1
    c1, c2 = input[index].split(": ")[1].split(", ").map{|v| v.split("=")[1].to_i + 10000000000000}
    index += 2
    puts "a1=#{a1}, b1=#{b1}, c1=#{c1}"
    puts "a2=#{a2}, b2=#{b2}, c2=#{c2}"

    det = a1 * b2 - a2 * b1
    puts det

    if det == 0
        puts "No unique solutions"
        next
    end


    nb_a = (c1 * b2 - c2 * b1) / det
    nb_b = (a1 * c2 - a2 * c1) / det

    if a1*nb_a + b1 * nb_b != c1 || a2*nb_a + b2 * nb_b != c2
        next
    end

    puts "#{nb_a}, #{nb_b}"
    costs << 3 * nb_a + nb_b
end

puts (costs.reduce(:+))


