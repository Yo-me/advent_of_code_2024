text = File.open("input.txt", "r").readlines
    
line_length = text[0].length
XMAS = "XMAS"
count = 0
(0...text.length).each do |line_index|
    (0...line_length).each do |col_index|
        if text[line_index][col_index] == "X"
            # Look left if possible
            if col_index >= XMAS.length - 1
                found = [true, true]
                (0...XMAS.length).each do |index|
                    if XMAS[XMAS.length - index - 1] != text[line_index][col_index - index]
                        found[0] = false
                    end
                    if XMAS[index] != text[line_index][col_index - index]
                        found[1] = false
                    end
                end
                count += found.count(true)
            end
            # Look right if possible
            if col_index + XMAS.length - 1 < line_length
                found = [true, true]
                (0...XMAS.length).each do |index|
                    if XMAS[XMAS.length - index - 1] != text[line_index][col_index + index]
                        found[0] = false
                    end
                    if XMAS[index] != text[line_index][col_index + index]
                        found[1] = false
                    end
                end
                count += found.count(true)
            end
            # Look down if possible
            if line_index + XMAS.length - 1 < text.length
                found = [true, true]
                (0...XMAS.length).each do |index|
                    if XMAS[XMAS.length - index - 1] != text[line_index + index][col_index]
                        found[0] = false
                    end
                    if XMAS[index] != text[line_index + index][col_index]
                        found[1] = false
                    end
                end
                count += found.count(true)
            end

            # Look up if possible
            if line_index >= XMAS.length - 1
                puts line_index
                found = [true, true]
                (0...XMAS.length).each do |index|
                    if XMAS[XMAS.length - index - 1] != text[line_index - index][col_index]
                        found[0] = false
                    end

                    if XMAS[index] != text[line_index - index][col_index]
                        found[1] = false
                    end
                end
                if found[0] == true || found[1] == true
                    puts "(#{line_index}, #{col_index})"
                end
                count += found.count(true)
            end
        end
    end
end

puts count
