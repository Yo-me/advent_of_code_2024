equations = []

def can_be_solved(equation)
    operators = [:+, :*]
    case equation[:terms].length
    when 1
        return equation[:result] == equation[:terms][0]
    else
        operators.each do |op|
            new_term = equation[:terms][0].method(op).call(equation[:terms][1])

            new_terms = [new_term, equation[:terms][2..-1]].flatten
            new_equation = equation.clone
            new_equation[:terms] = new_terms
            result = can_be_solved(new_equation)
            return result if result
        end
    end

    return false
end



File.open("input.txt", "r").each_with_index do |line, line_index|
    
    v = line.split(": ")
    equations << {
        :result => v[0].to_i,
        :terms => v[1].split(" ").map(&:to_i)
    }
end

puts (equations.map do |eq|
    if can_be_solved(eq)
        eq[:result]
    else
        0
    end
end).reduce(:+)