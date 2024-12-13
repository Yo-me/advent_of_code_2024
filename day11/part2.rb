require 'set'
values = nil

File.open("input.txt", "r").each do |line|
    values = line.strip.split(' ').map(&:to_i)
end



def compute_step(v)
    if(v == 0)
            return [v+1, nil]
    else
        log = (Math.log(v, 10).floor + 1).to_i
        if log  % 2 == 0
            v1 = (v / 10**(log/2)).to_i
            v2 = v - (v1 * 10**(log/2))
            return [v1, v2]
        else
            return [v * 2024, nil]
        end
    end
end
Stone_steps = Hash.new do |h, key|
    h[key] = compute_step(key)
end

Counts = Hash.new do |h, key|
    h[key] = Hash.new do |counts, step|
        counts[step] = compute_number(key, step)
    end
end

def compute_number(v, step)
    array = Stone_steps[v].compact

    case step
    when 1
        return array.length
    else
        count = (array.map do |stone|
            Counts[stone][step-1]
        end).reduce(:+)
        return count
    end
end

puts (values.map do |stone|
    Counts[stone][75]
end).reduce(:+)
