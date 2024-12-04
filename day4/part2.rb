reports = []

total = 0
enabled = true
File.open("input.txt", "r").each do |line|
    line.scan(/do\(\)|don't\(\)|mul\([1-9][0-9]?[0-9]?,[1-9][0-9]?[0-9]?\)/) do |match|
        case match
        when "do()"
            enabled = true
        when "don't()"
            enabled = false
        else
            if enabled
                match.scan(/mul\(([1-9][0-9]?[0-9]?),([1-9][0-9]?[0-9]?)\)/).each do |match2|
                    total += match2.map {|v| v.to_i }.reduce(:*)
                end
            end
        end
    end
end


puts total
