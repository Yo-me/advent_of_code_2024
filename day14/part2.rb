require 'set'
require 'chunky_png'
Map = []

size_x = 101
size_y = 103

robots = []

File.open("input.txt", "r").each do |line|
    pos, speed = line.split(" ").map {|v| v.split("=")[1].split(",").map(&:to_i)}
    robots << [pos, speed]
end


time = 753

while true
    break if time == 1001
    puts "time = #{time}"
    
    png = ChunkyPNG::Image.new(size_x, size_y, ChunkyPNG::Color.rgba(0, 0, 0, 255))

    robots.each do |r|
        pos = r[0]
        speed = r[1]
        end_x = (pos[0] + time * speed[0]) % size_x
        end_y = (pos[1] + time * speed[1]) % size_y

        png[end_x, end_y] = ChunkyPNG::Color.rgba(255,255,255,255)
    end
    png.save("img#{"%010d" % time}.png")
    time += 101
end



