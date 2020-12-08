
lines = readlines("input.txt")

let lineno = 1, executed = Set(), acc = 0
    while !(lineno in executed)
        println(lineno)
        push!(executed, lineno)
        current_instruction = lines[lineno]
        if contains(current_instruction, "jmp")
            lineno += parse(Int, split(current_instruction)[2])
        elseif contains(current_instruction, "nop")
            lineno += 1
        elseif contains(current_instruction, "acc")
            acc += parse(Int, split(current_instruction)[2])
            lineno += 1
        end
    end
    println("acc before second loop: $(acc)")
end
