require 'set'
blocks = []

File.open("input.txt", "r").each do |line|
    line.strip!
    block_id = 0
    reading_empty = false
    line.each_char do |c|
        count = c.to_i

        (0...count).each do |index|
            if reading_empty
                blocks << nil
            else
                blocks << block_id
            end
        end
        block_id += 1 if !reading_empty
        reading_empty = !reading_empty
    end
end

(blocks.length-1..0).step(-1).each do |index|

    next if blocks[index].nil?
    insert_pos = blocks.index(nil)

    if insert_pos < index
        blocks[insert_pos] = blocks[index]
        blocks[index] = nil
    end

end

checksum = 0
blocks.each_with_index do |v, index|
    next if v.nil?

    checksum += (v * index)
end

puts checksum