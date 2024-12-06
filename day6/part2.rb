require 'set'
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

def is_loop(p_grid, p_start_pos, p_start_direction)
    l_pos = p_start_pos.clone
    l_direction = p_start_direction
    l_visited = Array.new(p_grid.length) do |index|
        Array.new(p_grid[0].length, nil)
    end
    is_loop = false
    while true
        l_visited[l_pos[:y]][l_pos[:x]] = Set.new if l_visited[l_pos[:y]][l_pos[:x]].nil?
        if l_visited[l_pos[:y]][l_pos[:x]] === l_direction
            is_loop = true
            break
        end
        l_visited[l_pos[:y]][l_pos[:x]] << l_direction

        l_new_pos = move(l_pos, l_direction)

        if l_new_pos[:x] < 0 || l_new_pos[:x] >= p_grid[0].length || l_new_pos[:y] < 0 || l_new_pos[:y] >= p_grid.length
            break
        end

        if p_grid[l_new_pos[:y]][l_new_pos[:x]] == "#"
            l_direction = turn(l_direction)
        else
            l_pos = l_new_pos.clone
        end

    end

    is_loop
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

start_pos = pos.clone
start_direction = direction

while true
    new_pos = move(pos, direction)
    if new_pos[:x] < 0 || new_pos[:x] >= grid[0].length || new_pos[:y] < 0 || new_pos[:y] >= grid.length
        break
    end

    if grid[new_pos[:y]][new_pos[:x]] == "#"
        direction = turn(direction)
    else
        if new_pos != start_pos && visited[new_pos[:y]][new_pos[:x]] != "O"
            new_grid = grid.clone.map(&:clone)
            new_grid[new_pos[:y]][new_pos[:x]] = "#"
            if is_loop(new_grid, start_pos, start_direction)
                visited[new_pos[:y]][new_pos[:x]] = "O"
            end
        end
        pos = new_pos
    end
end

puts (visited.map do |v|
    v.count("O")
end).reduce(:+)