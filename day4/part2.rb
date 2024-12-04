text = File.open("input.txt", "r").readlines#.map {|l| l.strip }
    
line_length = text[0].length
XMAS = "XMAS"
count = 0
(0...text.length).each do |line_index|
    (0...line_length).each do |col_index|
        if text[line_index][col_index] == "A"
            if line_index > 0 && line_index < text.length - 1 && col_index > 0 && col_index < line_length - 1

                if (text[line_index - 1][col_index - 1] == "M" && text[line_index - 1][col_index + 1] == "S" && text[line_index + 1][col_index - 1] == "M" && text[line_index + 1][col_index + 1] == "S") || (text[line_index - 1][col_index - 1] == "S" && text[line_index - 1][col_index + 1] == "M" && text[line_index + 1][col_index - 1] == "S" && text[line_index + 1][col_index + 1] == "M")  || (text[line_index - 1][col_index - 1] == "M" && text[line_index - 1][col_index + 1] == "M" && text[line_index + 1][col_index - 1] == "S" && text[line_index + 1][col_index + 1] == "S")|| (text[line_index - 1][col_index - 1] == "S" && text[line_index - 1][col_index + 1] == "S" && text[line_index + 1][col_index - 1] == "M" && text[line_index + 1][col_index + 1] == "M")
                    count += 1
                end
            end
        end
    end
end

puts count
