constraints = Hash.new()
updates = []
read_constraints = true
File.open("input.txt", "r").each do |line|
    line = line.strip
    if line == ""
        read_constraints = false
        next
    elsif read_constraints
        constraint = line.split("|")
        if constraints.include?(constraint[1])
            constraints[constraint[1]] << constraint[0].to_i
        else
            constraints[constraint[1]] = [constraint[0].to_i]
        end
    else
        updates << line.split(",").map {|v| v.to_i}
    end
end

valid_updates = []

updates.each_with_index do |update, index|
    valid = true
    to_check = []
    update.each do |page|
        to_check.each do |num|
            key = num.to_s
            if constraints.include?(key) && constraints[key].include?(page)
                valid = false
                break
            end
        end
        if !valid
            break
        else
            to_check << page
        end
    end
    valid_updates << index if valid
end


puts (valid_updates.map do |update_index|
    middle = updates[update_index].length / 2
    updates[update_index][middle]
end).reduce(:+)
    
