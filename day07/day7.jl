
function parse_line(line)
    (thisbag, children) = split(line, " bags contain ")
    out = Dict{String,Int}()
    for slc in findall(r"[0-9] [\w\s]+ bag", children)
        result = match(r"([0-9]) ([\w\s]+) bag", children[slc])
        out[result.captures[2]] = parse(Int, result.captures[1])
    end
    return thisbag, out
end


# data: x1, x2, n
x1 = []
x2 = []
n = []
open("input.txt") do file
    for line in eachline(file)
        thisbag, out = parse_line(line)
        for (k, v) in out
            push!(x1, thisbag)
            push!(x2, k)
            push!(n, v)
        end
    end
end

function solvepart1()
    targets = ["shiny gold"]
    record_containers = Set()

    i = 1
    while ( length(targets) > 0 )
        allcontainers = reduce(union, map(target -> Set((x1[x2 .== target])), targets))
        containable_containers = Set()
        uncontainable_containers = Set()
        push!(record_containers, allcontainers...)
        for c in allcontainers
            if c in x2
                push!(containable_containers, c)
            else
                push!(uncontainable_containers, c)
            end
        end
        # global targets = [c for c in containable_containers]
        # global i += 1
        targets = [c for c in containable_containers]
        i += 1
    end
    println("loop repeated $(i) times")
    println(length(record_containers))  # 112
end

function countbags(thisbag)
    allbags = x2[ x1 .== thisbag ]
    nbags = n[x1 .== thisbag]
    rr = [nn * countbags(nextbag) for (nn, nextbag) in zip(nbags, allbags)]
    if length(rr) == 0
        return 1.0
    else
        return sum(rr) + 1
    end
end

function solvepart2()
    thisbag = "shiny gold"
    println(countbags(thisbag) - 1)  # subtract the outermost one shiny gold bag.
end

solvepart1()
solvepart2()