
# g = [0, 3, 6]
g = [5,1,9,18,13,8,0]

function nextturn!(g)
    if !(g[end] in g[1:end-1])
        push!(g, 0)
    else
        i = findlast(isequal(g[end]), g[1:end-1])
        push!(g, length(g) - i)
    end
end



for i in 1:2020
    nextturn!(g)
end
println(g[2020])


