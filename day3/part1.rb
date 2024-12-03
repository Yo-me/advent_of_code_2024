reports = []

total = 0
File.open("input.txt", "r").each do |line|
    line.scan(/mul\(([1-9][0-9]?[0-9]?),([1-9][0-9]?[0-9]?)\)/) do |match|
        total += match.map {|v| v.to_i }.reduce(:*)
    end
end


puts total
