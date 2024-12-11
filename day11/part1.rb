require 'set'
values = nil

File.open("input.txt", "r").each do |line|
    values = line.strip.split(' ').map(&:to_i)
end

(0...25).each do |i|
    index = 0
    
    while(index < values.length)
        if(values[index] == 0)
            values[index] += 1
        else
            s = values[index].to_s
            if s.length % 2 == 0
                v1 = s[0..s.length/2-1].to_i
                v2 = s[s.length/2..-1].to_i
                values[index] = v1
                values.insert(index+1, v2)
                index += 1
            else
                values[index] *= 2024
            end
        end
        index += 1
    end

    #puts values.inspect
    #break if i == 10
end
puts values.inspect
puts values.length
