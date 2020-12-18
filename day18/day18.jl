lines = readlines("input.txt")

function evalexpr(line)
    for m in eachmatch(r"\([^()]*\)", line)
        v = evalexpr(strip(m.match, ['(',')']))
        # println(m.match)
        return evalexpr(replace(line, m.match => v, count=1))
    end
    m2 = match(r"([0-9]+) ([*+]) ([0-9]+)", line)
    if m2 == nothing
        return line
    else
        a, op, b = m2.captures
        if op == "+"
            v = parse(Int, a) + parse(Int, b)
        elseif op == "*" 
            v = parse(Int, a) * parse(Int, b)
        end
        return evalexpr(replace(line, m2.match => string(v), count=1))
    end
end

function evalexpr2(line)
    # println(line)
    for m in eachmatch(r"\([^()]*\)", line)
        v = evalexpr2(strip(m.match, ['(',')']))
        # println(m.match)
        return evalexpr2(replace(line, m.match => v, count=1))
    end
    m2 = match(r"([0-9]+) \+ ([0-9]+)", line)
    if !(m2 == nothing)
        a, b = m2.captures
        v = parse(Int, a) + parse(Int, b)
        return evalexpr2(replace(line, m2.match => string(v), count=1))
    else
        m2 = match(r"([0-9]+) \* ([0-9]+)", line)
        if !(m2 == nothing)
            a, b = m2.captures
            v = parse(Int, a) * parse(Int, b)
            return evalexpr2(replace(line, m2.match => string(v), count=1))
        end
    end
    line
end


@assert evalexpr("1 + 2 * 3 + 4 * 5 + 6") == "71"
@assert evalexpr("1 + (2 * 3) + (4 * (5 + 6))") == "51"
@assert evalexpr("2 * 3 + (4 * 5)") == "26"
@assert evalexpr("5 + (8 * 3 + 9 + 3 * 4 * 3)") == "437"
@assert evalexpr("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == "12240"
@assert evalexpr("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == "13632"

a = map(evalexpr, lines)
ans = sum(parse.(Int64, a))
println(ans)

@assert evalexpr2("1 + (2 * 3) + (4 * (5 + 6))") == "51"
@assert evalexpr2("2 * 3 + (4 * 5)") == "46"
@assert evalexpr2("5 + (8 * 3 + 9 + 3 * 4 * 3)") == "1445"

a = map(evalexpr2, lines)
ans = sum(parse.(Int64, a))
println(ans)

