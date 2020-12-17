lines = readlines("input.txt")

active = Set()

let z = 0
    for (x, line) in enumerate(lines)
        for (y, j) in enumerate(collect(line))
            if j == '#'
                push!(active, (x-1, y-1, z))
            end
        end
    end
end

@assert sum(map(x -> count(isequal('#'), x), lines)) == length(active)

function nactive(active, xyz)
    x, y, z = xyz
    nactive = 0
    for dx in [-1, 0, 1]
        for dy in [-1, 0, 1]
            for dz in [-1, 0, 1]
                if dx == 0 && dy == 0 && dz == 0
                    continue
                else
                    if (x+dx, y+dy, z+dz) in active
                        nactive += 1
                    end
                end
            end
        end
    end
    nactive
end

function cycle!(active)
    addi = []
    removei = []
    inds = CartesianIndices((
        min([x[1] for x in active]...)-1:max([x[1] for x in active]...)+1,
        min([x[2] for x in active]...)-1:max([x[2] for x in active]...)+1,
        min([x[3] for x in active]...)-1:max([x[3] for x in active]...)+1))
    for xyz in inds
        if (xyz.I in active)
            if !(nactive(active, xyz.I) in [2,3])
                push!(removei, xyz.I)
            end
        elseif !(xyz.I in active) && (nactive(active, xyz.I) in [3])
            push!(addi, xyz.I)
        end
    end
    for j in addi
        push!(active, j)
    end
    for j in removei
        pop!(active, j)
    end
end

for i in 1:6
    cycle!(active)
end
println(length(active))    # 304