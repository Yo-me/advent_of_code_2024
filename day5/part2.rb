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

invalid_updates = []

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
    invalid_updates << index if !valid
end

invalid_updates.map! do |update_index|
    new_update = []
    updates[update_index].each do |page|
        insert_index = nil
        new_update.each_with_index do |compare, index|
            key = compare.to_s
            if constraints.include?(key) && constraints[key].include?(page)
                insert_index = index
                break
            end
        end
        if insert_index
            new_update.insert(insert_index, page)
        else
            new_update << page
        end
    end
    new_update
end


puts (invalid_updates.map do |update|
    middle = update.length/2
    update[middle]
end).reduce(:+)
    
