require 'set'


class Block
    attr_accessor :id, :size, :prev, :next

end

class List
    attr_accessor :length, :head, :tail

    def initialize()
        @head = nil
        @tail = nil
        @length = 0
    end

    def <<(block)
        if @head.nil?
            @head = block
            @tail = block
            @head.prev = nil
            @head.next = nil
        else
            block.prev = @tail
            block.next = nil
            @tail.next = block
            @tail = block
        end
        @length += 1
    end

    def remove(block)
        if block == @tail
            @tail = block.prev
            @tail.next = nil
        elsif block == @head
            @head = block.next
            @head.prev = nil
        else
            block.next.prev = block.prev
            block.prev.next = block.next
        end
        @length -= 1
    end

    def insert_after(b, to_insert)
        to_insert.next = b.next
        b.next.prev = to_insert if b.next
        to_insert.prev = b
        b.next = to_insert
    end

    def to_s
        output = ""
        a = @head
        while a
            output += (a.id.nil? ? "." : a.id.to_s) * a.size
            a = a.next
        end
        output
    end
end


blocks = List.new

File.open("input.txt", "r").each do |line|
    line.strip!
    block_id = 0
    reading_empty = false
    line.each_char do |c|
        block = Block.new
        block.size = c.to_i

        if reading_empty
            block.id = nil
        else
            block.id = block_id
        end
        blocks << block
        block_id += 1 if !reading_empty
        reading_empty = !reading_empty
    end
end

puts blocks

to_relocate = blocks.tail

while !to_relocate.nil?
    if !to_relocate.id.nil?

        b = blocks.head

        while b != to_relocate

            if b.id.nil? && b.size >= to_relocate.size
                remaining_size = b.size - to_relocate.size
                empty = Block.new
                empty.id = nil
                empty.size = to_relocate.size
                next_block = to_relocate.next
                blocks.remove(to_relocate)
                blocks.insert_after(to_relocate.prev, empty)
                blocks.insert_after(b.prev, to_relocate)
                if remaining_size == 0
                    blocks.remove(b)
                else
                    b.size = remaining_size
                end
                to_relocate = next_block

                break
            end

            b = b.next
        end
    end
    if to_relocate
        to_relocate = to_relocate.prev
    else
        to_relocate = blocks.tail
    end
end

b = blocks.head

checksum = 0
index = 0

while !b.nil?
    if !b.id.nil?
        (index...index + b.size).each do |i|
            checksum += i * b.id
        end
    end
    index += b.size
    b = b.next
end
puts blocks

puts checksum