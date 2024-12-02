reports = []

File.open("input.txt", "r").each do |line|
    reports << line.split(" ").map {|v| v.to_i }
end


puts (reports.map do |report|
    direction = nil
    (report.each_cons(2).map do |v|
        diff = v[0] - v[1]
        current_direction = diff < 0 ? :decr : :incr
        if direction.nil?
            direction = current_direction
        end
        
        if direction != current_direction
            false
        elsif diff.abs >= 1 && diff.abs <= 3
            true
        else
            false
        end
    end).count(true) == report.length - 1 
end).count(true)