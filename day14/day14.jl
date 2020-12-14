lines = readlines("input.txt")

# part 1 ------------
mask = nothing
mem = Dict()
for line in lines
    if startswith(line, "mask")
        global mask = split(line, " = ")[2]
    elseif startswith(line, "mem")
        loc = parse(Int, split(split(line, "[")[2], "]")[1])
        num = parse(Int, split(line, " = ")[2])
        numstr = string(num, base=2, pad=36)
        numstr = map(x -> x[1] == 'X' ? x[2] : x[1], zip(collect(mask), collect(numstr)))
        num = parse(Int, join(numstr), base=2)
        mem[loc] = num
    end
end
println(sum(values(mem)))
# 4297467072083


# part 2 ------------
function genfloating!(a, n)
    b = copy(a) .+ 2^n
    # we either add or don't add 2^n number.
    prepend!(a, b)
end

mem = Dict()
for line in lines
    if startswith(line, "mask")
        global mask = split(line, " = ")[2]
    elseif startswith(line, "mem")
        loc = parse(Int, split(split(line, "[")[2], "]")[1])
        num = parse(Int, split(line, " = ")[2])
        locstr = string(loc, base=2, pad=36)
        locstr = map(x -> x[1] == 'X' ? 'X' : (x[1] == '1' ? '1' : x[2]), zip(collect(mask), collect(locstr)))
        loc = parse(Int, replace(join(locstr), "X" => "0"), base=2)
        i = findall(isequal('X'), locstr)
        possibleloc = [loc]
        for j in i
            genfloating!(possibleloc, 36-j)
        end
        for c in possibleloc
            mem[c] = num
        end
    end
end
println(sum(values(mem)))
# 5030603328768
