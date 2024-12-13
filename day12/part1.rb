require 'set'
Map = []


File.open("input.txt", "r").each do |line|
    Map << line.strip
end

Visited = Array.new(Map.length) do |i|
    String.new(" " * Map[0].length)
end

puts Visited.inspect
def compute_for_region(line, col, area = 0, perimeter = 0)
    Visited[line][col] = "#"
    area += 1
    if line == 0 || (line > 0 && Map[line-1][col] != Map[line][col])
        perimeter += 1
    elsif line > 0 && Visited[line-1][col] != '#'
        area, perimeter = compute_for_region(line - 1, col, area, perimeter)
    end

    if line == Map.length-1 || (line < Map.length-1 && Map[line+1][col] != Map[line][col])
        perimeter += 1
    elsif line < Map.length-1 && Visited[line+1][col] != '#'
        area, perimeter = compute_for_region(line + 1, col, area, perimeter)
    end
    
    if col == 0 || (col > 0 && Map[line][col-1] != Map[line][col])
        perimeter += 1
    elsif col > 0 && Visited[line][col-1] != "#"
        area, perimeter = compute_for_region(line, col - 1, area, perimeter)
    end

    if col == Map[0].length - 1 || (col < Map[0].length - 1 && Map[line][col + 1] != Map[line][col])
        perimeter += 1
    elsif col < Map[0].length - 1 && Visited[line][col+1] != '#'
        area, perimeter = compute_for_region(line, col + 1, area, perimeter)
    end

    return area, perimeter

end

costs = []
(0...Map.length).each do |line|
    (0...Map[0].length).each do |col|
        if Visited[line][col] != '#'
            area, perimeter = compute_for_region(line, col)
            costs << area * perimeter 
        end
    end
end

puts (costs.reduce(:+))



