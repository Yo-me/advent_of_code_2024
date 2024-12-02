reports = []

File.open("input.txt", "r").each do |line|
    reports << line.split(" ").map {|v| v.to_i }
end

def check_record(a, b, direction)
    difference = a - b
    current_direction = difference > 0 ? :incr : :decr
    direction = current_direction if direction.nil?

    valid = (direction == current_direction) && (difference.abs >= 1 && difference.abs <= 3)
    [direction, valid]
end


def check_report(report, nb_remove = 0)
    direction = nil
    valid = true

    return false if nb_remove > 1

    (0...(report.length-1)).each do |index|
        direction, valid = check_record(report[index], report[index+1], direction)
        if !valid
            (0...report.length).each do |i|
                new_array = Array.new(report)
                new_array.delete_at(i)
                valid = check_report(new_array, nb_remove + 1)
                break if valid
            end
            break
        end
    end

    return valid
end

puts (reports.map do |report|
    check_report(report)
end).count(true)