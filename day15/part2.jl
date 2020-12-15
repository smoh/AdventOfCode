# --- part 2
# let's only keep the last time each number was spoken

gg = Dict(
    5 => 1,
    1 => 2,
    9 => 3,
    18 => 4,
    13 => 5,
    8 => 6,
    "last" => 0,
    "lastturn" => 7
)


function nextturn2!(g)
    if !(g["last"] in keys(g))
        g[g["last"]] = g["lastturn"]
        g["last"] = 0
        g["lastturn"] = g["lastturn"] + 1
    else
        i = g["lastturn"] - g[g["last"]]
        g[g["last"]] = g["lastturn"]
        g["last"] = i
        g["lastturn"] = g["lastturn"] + 1
    end
end


while (gg["lastturn"] != 30000000)
    nextturn2!(gg)
end
println(gg["last"])   # 323780

