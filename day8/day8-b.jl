
lines = readlines("input.txt")

function checkfixed(lines)
    lineno = 1
    executed = Set()
    acc = 0
    while (true)
        if (lineno in executed)
            return 0, acc
        elseif (lineno > length(lines))
            return 1, acc
        end
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
end

let lineno = 1, executed = Set(), jmp = Set(), nop = Set(), acc = 0
    # find out where to fix
    while (true)
        if lineno in executed
            break
        end
        push!(executed, lineno)
        current_instruction = lines[lineno]
        if contains(current_instruction, "jmp")
            push!(jmp, lineno)
            lineno += parse(Int, split(current_instruction)[2])
        elseif contains(current_instruction, "nop")
            push!(nop, lineno)
            lineno += 1
        elseif contains(current_instruction, "acc")
            acc += parse(Int, split(current_instruction)[2])
            lineno += 1
        end
    end

    # try every fix
    for jmptofix in Iterators.Stateful(jmp)
        newboot = copy(lines)
        newboot[jmptofix] = replace(newboot[jmptofix], "jmp" => "nop")
        r = checkfixed(newboot)
        if r[1] == 1
            println("Fixed by changing $(jmptofix) jmp -> nop, acc=$(r[2])")
        end
    end
    for noptofix in Iterators.Stateful(nop)
        newboot = copy(lines)
        newboot[noptofix] = replace(newboot[noptofix], "nop" => "jmp")
        r = checkfixed(newboot)
        if r[1] == 1
            println("Fixed by changing $(noptofix) nop -> jmp, acc=$(r[2])")
        end
    end
end
# Fixed by changing 448 jmp -> nop, acc=944

