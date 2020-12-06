

open("input.txt") do f
    s = read(f, String)
    groups = split.(split(s, "\n\n"))
    count = map(g -> length(Set(collect(join(g)))), groups)
    println(sum(count))    # 6351

    count2 = map(g -> length( reduce(intersect, collect.(g)) ), groups)
    println(sum(count2)) # 3143
end
