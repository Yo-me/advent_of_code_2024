require 'set'
map = []


def walk(map, row, col)
    value = map[row][col]
    case value
    when 9
        return 1
    else
        count = 0
        if row > 0 && map[row-1][col] == value + 1
            count += walk(map, row - 1, col)
        end
        if row < map.length - 1 && map[row + 1][col] == value + 1
            count += walk(map, row + 1, col)
        end
        if col > 0 && map[row][col - 1] == value + 1
            count += walk(map, row, col - 1)
        end
        if col < map[row].length-1 && map[row][col + 1] == value + 1
            count += walk(map, row, col + 1)
        end
        return count
    end
end

File.open("input.txt", "r").each do |line|
    map << line.strip.each_char.map(&:to_i)
end

count = 0
(0...map.length).each do |row|
    (0...map[0].length).each do |col|
        if map[row][col] == 0
            current_count = walk(map, row, col)
            count += current_count
        end
    end
end

puts count
