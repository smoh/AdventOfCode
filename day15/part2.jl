# --- part 2
# let's only keep the last time each number was spoken

function nextturn2!(g, last, i)
    n = i - get(g, last, i)
    g[last] = i
    g, n, i+1
end

let n = 0, i = 7
    gg = Dict(
        5 => 1,
        1 => 2,
        9 => 3,
        18 => 4,
        13 => 5,
        8 => 6,
        0 => 7
    )
    while (i != 30000000)
        gg, n, i = nextturn2!(gg, n, i)
    end
    println(n)
end
# println(gg["last"])   # 323780

