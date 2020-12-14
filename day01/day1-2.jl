
d = readlines("input.txt")
dd = parse.(Int, d)

println("part 1: What is the product of two numbers that sum to 2020?")
for i in eachindex(dd)
    for j in 1:1:i
        if dd[i] + dd[j] === 2020
            println("output: $(dd[i]) $(dd[j]) product: $(dd[i]*dd[j])")
        end
    end
end

println("part 2: What is the product of three numbers that sum to 2020?")
for i in eachindex(dd)
    for j in 1:1:i
        for k in 1:1:j
            if dd[i] + dd[j] + dd[k] === 2020
                println("output: $(dd[i]) $(dd[j]) $(dd[k]) product: $(dd[i]*dd[j]*dd[k])")
            end
        end
    end
end
