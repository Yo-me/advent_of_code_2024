require 'set'
Map = []


File.open("input.txt", "r").each do |line|
    Map << line.strip
end

Visited = Array.new(Map.length) do |i|
    String.new(" " * Map[0].length)
end

HorzBorders = Hash.new do |h, v|
    h[v] = []
end

def add_border(borders, k, v)
    inserted = false
    borders[k].map! do |border|
        if v == border.min-1
            inserted = true
            (v..border.max)
        elsif v == border.max+1
            inserted = true
            (border.min..v)
        else
            border
        end
    end

    if !inserted
        borders[k] << (v..v)
    end
end

def compute_for_region(line, col, left_borders, right_borders, top_borders, bottom_borders, area = 0)
    Visited[line][col] = "#"
    area += 1

    top_border = line == 0 || (line > 0 && Map[line-1][col] != Map[line][col])
    bottom_border = line == Map.length-1 || (line < Map.length-1 && Map[line+1][col] != Map[line][col])
    left_border = col == 0 || (col > 0 && Map[line][col-1] != Map[line][col])
    right_border = col == Map[0].length - 1 || (col < Map[0].length - 1 && Map[line][col + 1] != Map[line][col])

    if left_border
        add_border(left_borders, col, line)
    end

    if right_border
        add_border(right_borders, col, line)
    end

    if top_border
        add_border(top_borders, line, col)
    end

    if bottom_border
        add_border(bottom_borders, line, col)
    end

    if !top_border && line > 0 && Visited[line-1][col] != '#'
        area = compute_for_region(line - 1, col, left_borders, right_borders, top_borders, bottom_borders, area)
    end

    if !bottom_border && line < Map.length-1 && Visited[line+1][col] != '#'
        area = compute_for_region(line + 1, col, left_borders, right_borders, top_borders, bottom_borders, area)
    end
    
    if !left_border && col > 0 && Visited[line][col-1] != "#"
        area = compute_for_region(line, col - 1, left_borders, right_borders, top_borders, bottom_borders, area)
    end

    if !right_border && col < Map[0].length - 1 && Visited[line][col+1] != '#'
        area = compute_for_region(line, col + 1, left_borders, right_borders, top_borders, bottom_borders, area)
    end

    return area
end

costs = []
(0...Map.length).each do |line|
    (0...Map[0].length).each do |col|
        if Visited[line][col] != '#'
            leftBorders = Hash.new do |h, v|
                h[v] = []
            end
            rightBorders = Hash.new do |h, v|
                h[v] = []
            end
            topBorders = Hash.new do |h, v|
                h[v] = []
            end
            bottomBorders = Hash.new do |h, v|
                h[v] = []
            end
            area = compute_for_region(line, col, leftBorders, rightBorders, topBorders, bottomBorders)
            costs << ([leftBorders, rightBorders, topBorders, bottomBorders].map do |map|
                count = 0
                map.each do |k, v|
                    v.sort! {|a,b| a.min <=> b.min}
                    puts v.inspect
                    index = 0

                    while index < v.length-1
                        if index < v.length - 1 && v[index].max == v[index+1].min
                            v[index] = (v[index].min..v[index+1].max)
                            v.delete_at(index+1)
                        else
                            index+=1
                        end
                    end
                    count += v.length
                end
                count
            end).reduce(:+) * area
        end
    end
end

puts (costs.reduce(:+))
