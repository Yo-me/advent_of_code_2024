require 'set'
map = []


def walk(map, row, col, nineheights = Set.new)
    value = map[row][col]
    puts "#{row}, #{col} : #{value}"
    case value
    when 9
        nineheights << {:row => row, :col => col}
    else
        count = 0
        if row > 0 && map[row-1][col] == value + 1
            walk(map, row - 1, col, nineheights)
        end
        if row < map.length - 1 && map[row + 1][col] == value + 1
            walk(map, row + 1, col, nineheights)
        end
        if col > 0 && map[row][col - 1] == value + 1
            walk(map, row, col - 1, nineheights)
        end
        if col < map[row].length-1 && map[row][col + 1] == value + 1
            walk(map, row, col + 1, nineheights)
        end
        return nineheights if value == 0
    end
end

File.open("input.txt", "r").each do |line|
    map << line.strip.each_char.map(&:to_i)
end

count = 0
(0...map.length).each do |row|
    (0...map[0].length).each do |col|
        if map[row][col] == 0
            current_count = walk(map, row, col).length
            puts "#{row},#{col}: #{current_count}"
            count += current_count
        end
    end
end

puts count
