lines = readlines("input.txt")

valid = Dict()
for line in lines[1:20]
    (key, ranges) = split(line, ": ")
    (range1, range2) = split(ranges, " or ")
    valid[key] = (parse.(Int, split(range1,"-")),
                  parse.(Int, split(range2,"-")))
end 

function check(num, valid)
    for (k,v) in valid
        good = ((num>=v[1][1]) && (num<=v[1][2])) || ((num>=v[2][1]) && (num<=v[2][2]))
        if good
            return true
        end
    end
    false
end

function checkfield(num, valid, k)
    v = valid[k]
    good = ((num>=v[1][1]) && (num<=v[1][2])) || ((num>=v[2][1]) && (num<=v[2][2]))
    good
end
        
    
        
    
let c = [], invalid = []
    for (j, line) in enumerate(lines[26:end])
        nums = parse.(Int, split(line, ','))
        for num in nums
            if !(check(num, valid))
                push!(c, num)
                push!(invalid, j)
            end
        end
    end
    println(sum(c))             # 26026
    println(length(invalid))    # 55
    fields = collect(keys(valid))
    numfields = length(fields)

    poss = []
    for i in 1:numfields
        a = []
        for (j, line) in enumerate(lines[26:end])
            if j in invalid
                continue
            end
            nums = parse.(Int, split(line, ','))
            num = nums[i]
            validfor = Set()
            for (k, key) in enumerate(fields)
                if checkfield(num, valid, key)
                    push!(validfor, key)
                end
            end
            push!(a, validfor)
        end
        push!(poss, (i, reduce(intersect, a)))
    end

    # starting from the largest set, remove things in the smaller sets
    sort!(poss, by=x -> length(x[2]), rev=true)
    positions = []
    for (i, (pos, keyset)) in enumerate(poss)
        for (pos2, keyset2) in poss[i+1:end]
            setdiff!(keyset, keyset2)
        end
        push!(positions, (pos, pop!(keyset)))
    end

    ans = 1
    nums = parse.(Int, split(lines[23], ','))
    for (pos, label) in positions
        if startswith(label, "departure")
            ans *= nums[pos]
        end
    end
    println(ans)    # 1305243193339

end

