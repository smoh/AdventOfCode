function solvepart1()
    open("input.txt") do file
        nvalid = 0
        npassport = 0
        fields = Set{String}()
        for line in eachline(file)
            if line == ""
                npassport += 1
                if issubset(Set(["byr","iyr","eyr","hgt","hcl", "ecl","pid"]), fields)
                    nvalid += 1
                end
                fields = Set{String}()
            else
                for item in split(line)
                    fieldname = split(item, ':')[1]
                    push!(fields, fieldname)
                end
            end
        end
        println("$(npassport) nvalid: $(nvalid)")
    # there is no newline following the last item; manually check last passport
    npassport += 1
    if issubset(Set(["byr","iyr","eyr","hgt","hcl", "ecl","pid"]), fields)
        nvalid += 1
    end
    end
end

function isvalid(p::Dict)
    valid = true
    valid *= issubset(["byr","iyr","eyr","hgt","hcl", "ecl","pid"], keys(p))
    for (k, v) in p
        if k == "byr"
            y = parse(Int, v)
            valid *= (1920<=y) && (y<=2002)
        elseif k == "iyr"
            y = parse(Int, v)
            valid *= (2010<=y) && (y<=2020)
        elseif k == "eyr"
            y = parse(Int, v)
            valid *= (2020<=y) && (y<=2030)
        elseif k == "hgt"
            if occursin("cm", v)
                v = parse(Float64, split(v, "cm")[1])
                valid *= (v>=150) && (v<=193)
            elseif occursin("in", v)
                v = parse(Float64, split(v, "in")[1])
                valid *= (v>=59) && (v<=76)
            else
                valid *= false
            end
        elseif k == "hcl"
            tmp = match(r"#([0-9a-f]*)$", v)
            valid *= (tmp !== nothing) && (length(tmp.captures[1]) == 6)
        elseif k == "ecl"
            valid *= issubset([v], ["amb","blu","brn","gry","grn","hzl","oth"])
        elseif k == "pid"
            tmp = match(r"^([0-9]+)$",v)
            valid *= (tmp !== nothing) && (length(tmp.captures[1]) == 9)
        end
    end
    return valid
end




function solvepart2()
    open("input.txt") do file
        nvalid = 0
        npassport = 0
        passport = Dict()
        for line in eachline(file)
            if line == ""
                npassport += 1
                if isvalid(passport)
                    nvalid += 1
                end
                passport = Dict()
            else
                for item in split(line)
                    (k,v) = split(item, ':')
                    passport[k] = v
                end
            end
        end
        npassport += 1
        if isvalid(passport)
            nvalid += 1
        end
        println("$(npassport) nvalid: $(nvalid)")
    end
end

@time solvepart1()
@time solvepart2()