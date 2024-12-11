require 'set'
values = nil

File.open("input.txt", "r").each do |line|
    values = line.strip.split(' ').map(&:to_i)
end

(0...75).each do |i|
    index = 0
    size = values.length
    while(index < size)
        if(values[index] == 0)
            values[index] += 1
        else
            log = (Math.log(values[index], 10).floor + 1).to_i
            if log  % 2 == 0
                v1 = (values[index] / 10**(log/2)).to_i
                v2 = values[index] - (v1 * 10**(log/2))
                values[index] = v1
                values << v2
            else
                values[index] *= 2024
            end
        end
        index += 1
    end

    #puts values.inspect
    #break if i == 1
end
puts values.inspect
puts values.length
