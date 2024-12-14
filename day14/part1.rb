require 'set'
Map = []

size_x = 101
size_y = 103
time = 100

quadrants = [0, 0, 0, 0]

File.open("input.txt", "r").each do |line|
    pos, speed = line.split(" ").map {|v| v.split("=")[1].split(",").map(&:to_i)}

    end_x = (pos[0] + time * speed[0]) % size_x
    end_y = (pos[1] + time * speed[1]) % size_y

    horz_mid = (size_x - 1)/2
    vert_mid = (size_y - 1)/2

    if end_x < horz_mid && end_y < vert_mid
        quadrants[0] += 1
    elsif end_x > horz_mid && end_y < vert_mid
        quadrants[1] += 1
    elsif end_x > horz_mid && end_y > vert_mid
        quadrants[2] += 1
    elsif end_x < horz_mid && end_y > vert_mid
        quadrants[3] += 1
    end
end

puts quadrants.reduce(:*)


