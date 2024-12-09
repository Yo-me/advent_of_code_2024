require 'set'

class Point
    attr_accessor :x, :y
    def initialize(x, y)
        @x = x
        @y = y
    end

    def -(other)
        Point.new(@x - other.x, @y - other.y)
    end

    def length()
        Math.sqrt(@x**2 + @y**2)
    end

    def normalize()
        l = self.length()
        Point.new(@x / l, @y / l)
    end

    def *(dist)
        Point.new(@x * dist, @y * dist)
    end

    def +(other)
        Point.new(@x + other.x, @y + other.y)
    end

    def to_s()
        "{#{@x}, #{@y}}"
    end

    def inspect()
        self.to_s
    end

    def ==(other)
        @x == other.x && y == other.y
    end

    def eql?(other)
        @x == other.x && @y == other.y
    end

    def hash()
        [@x, @y].hash
    end

    def <=>(other)
        if @x < other.x
            -1
        elsif @x > other.x
            1
        elsif @y < other.y
            -1
        elsif @y > other.y
            1
        else
            0
        end
    end
end

antennas = {}

map = []

File.open("input.txt", "r").each_with_index do |line, row_index|
    line.strip!
    map << line
    (0...line.length).each do |col_index|
        c = line[col_index]
        if c != "."
            antennas[c] = [] if !antennas.has_key?(c)
            antennas[c] << Point.new(col_index, row_index)
        end
    end
end

antinodes = Set.new

antennas.each do |freq, array|
    array.combination(2).each do |pair|
        dir = (pair[0] - pair[1])
        
        (0..100).each do |factor|
            offset = dir
            antinode = pair[0] + (offset * factor)
            if antinode.x >= 0 && antinode.x < map[0].length && antinode.y >= 0 && antinode.y < map.length
                antinodes << antinode
                map[antinode.y][antinode.x] = "#"
            end
            offset = dir * -1
            antinode = pair[1] + (offset * factor)
            if antinode.x >= 0 && antinode.x < map[0].length && antinode.y >= 0 && antinode.y < map.length
                    antinodes << antinode
            end
        end
    end
end
map.each do |l|
    puts l
end
puts antinodes.length
