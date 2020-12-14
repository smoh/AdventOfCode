using LinearAlgebra

x = parse.(Int, readlines("input.txt"))
preamble = 25

for i in preamble+1:length(x)
    y = x[i-preamble:i-1]
    @assert length(y) === preamble
    sums = transpose(y) .+ y[2:end]
    z = Set(sums)
    if x[i] in z
        continue
    else
        println("$(i), $(x[i])")
        break
    end
end


for istart in 1:(633-2)
    for iend in 2:(633-1)
        if sum(x[istart:iend]) == x[633]
            println(min(x[istart:iend]...) + max(x[istart:iend]...))
            break
        end
    end
end

# output
# 633, 393911906
# 59341885