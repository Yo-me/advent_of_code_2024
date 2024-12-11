require 'set'
values = nil

class Block
    attr_accessor :value, :prev, :next

    def initialize(value)
        @value = value
    end
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
        @length += 1
    end

    def to_s
        output = ""
        a = @head
        while a
            output += a.value.to_s + " "
            a = a.next
        end
        output
    end
end

values = List.new

File.open("input.txt", "r").each do |line|
    line.strip.split(' ').map(&:to_i).each {|v| values << Block.new(v); break}
end

(0...75).each do |i|
    puts i
    current = values.head
    
    while(current != nil)
        if(current.value == 0)
            current.value += 1
        else
            s = current.value.to_s
            if s.length % 2 == 0
                v1 = s[0..s.length/2-1].to_i
                v2 = s[s.length/2..-1].to_i
                current.value = v1
                values.insert_after(current, Block.new(v2))
                current = current.next
            else
                current.value *= 2024
            end
        end
        current = current.next

    end

    #puts values
    #break if i == 10
end
puts values.length
