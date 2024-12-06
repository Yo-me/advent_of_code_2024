
grid = []
visited = []

pos = {:x => 0, :y => 0}
direction = nil

def move(pos, direction)
    new_pos = pos.clone()
    case direction
    when :up
        new_pos[:y] -= 1
    when :down
        new_pos[:y] += 1
    when :left
        new_pos[:x] -= 1
    when :right
        new_pos[:x] += 1
    end

    new_pos
end

def turn(direction)
    case direction
    when :up
        :right
    when :down
        :left
    when :left
        :up
    when :right
        :down
    end
end

File.open("input.txt", "r").each_with_index do |line, line_index|
    grid << line.strip
    visited << line.strip

    if index = line.index(/\^|>|<|v/)
        pos[:x] = index
        pos[:y] = line_index
        case line[index]
        when "^"
            direction = :up
        when ">"
            direction = :right
        when "<"
            direction = :left
        when "v"
            direction = :down
        end
    end
end
visited[pos[:y]][pos[:x]] = "X"

while true
    new_pos = move(pos, direction)
    if new_pos[:x] < 0 || new_pos[:x] >= grid[0].length || new_pos[:y] < 0 || new_pos[:y] >= grid.length
        break
    end

    if grid[new_pos[:y]][new_pos[:x]] == "#"
        direction = turn(direction)
    else
        pos = new_pos
        visited[pos[:y]][pos[:x]] = "X"
    end
end

puts (visited.map do |v|
    puts v
    v.count("X")
end).reduce(:+)