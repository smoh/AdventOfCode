using BenchmarkTools

function solvepart1()
    open("input.txt") do file
        numtrees = 0
        patternwidth = 0
        for (index, line) in enumerate(eachline(file))
            if index == 1
                patternwidth = length(line)
                continue
            end
            numtrees += Int(line[(3*(index-1)) % patternwidth + 1] == '#')
        end
        println("tree count: $(numtrees)")
    end
end

function counttrees(right::Int, down::Int)
    numtrees = 0
    open("input.txt") do file
        patternwidth = 0
        for (index, line) in enumerate(eachline(file))
            # we start at top left corner; ignore first line
            if index == 1
                patternwidth = length(line)
                continue
            end
            if (index-1) % down == 0
                step::Int = (index-1)/down
                numtrees += Int(line[(right*step) % patternwidth + 1] == '#')
            end
        end
        println("tree count: $(numtrees)")
    end
    return numtrees
end

function solvepart2()
    prod::Int = 1
    prod*=counttrees(1,1)
    prod*=counttrees(3,1)
    prod*=counttrees(5,1)
    prod*=counttrees(7,1)
    prod*=counttrees(1,2)
    println("answer part 2: $(prod)")
end

@time solvepart1()
@time solvepart2()