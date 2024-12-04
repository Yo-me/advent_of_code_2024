text = File.open("input.txt", "r").readlines#.map {|l| l.strip }
    
line_length = text[0].length
XMAS = "XMAS"
count = 0
(0...text.length).each do |line_index|
    (0...line_length).each do |col_index|
        if text[line_index][col_index] == "X"
            found = Array.new(8, true)
            (0...XMAS.length).each do |index|
                found[0] = false if XMAS[index] != text[line_index][col_index + index]
                found[1] = false if (col_index - (XMAS.length - 1)) < 0 || XMAS[index] != text[line_index][col_index - index]

                # we can look down
                if text[line_index + index]
                    found[2] = false if XMAS[index] != text[line_index + index][col_index]
                    found[3] = false if XMAS[index] != text[line_index + index][col_index + index]
                    found[4] = false if (col_index - (XMAS.length - 1)) < 0 || XMAS[index] != text[line_index + index][col_index - index]
                else
                    found[2] = false
                    found[3] = false
                    found[4] = false
                end
                #we can look up
                if line_index - (XMAS.length - 1) >= 0
                    found[5] = false if XMAS[index] != text[line_index - index][col_index]
                    found[6] = false if XMAS[index] != text[line_index - index][col_index + index]
                    found[7] = false if (col_index - (XMAS.length - 1)) < 0 || XMAS[index] != text[line_index - index][col_index - index]
                else
                    found[5] = false
                    found[6] = false
                    found[7] = false
                end
            end
            puts "(#{line_index},#{col_index}) -> #{found.count(true)} : #{found.inspect}" if found.count(true) != 0
            count += found.count(true)
        end
    end
end

puts count
