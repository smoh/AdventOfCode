function binary_to_decimal(arr::Array)
    num = 0
    for (p, count) in enumerate(arr[end:-1:begin])
        num += 2^(p-1) * count
    end
    num
end

function parse_boarding_pass(s::String)
    row = [ c == 'F' ? 0 : 1 for c in s[1:7]]
    col = [ c == 'L' ? 0 : 1 for c in s[8:end]]
    rownum = binary_to_decimal(row)
    colnum = binary_to_decimal(col)
    seatid = rownum * 8 + colnum
    rownum, colnum, seatid
end

@assert parse_boarding_pass("BFFFBBFRRR") === (70, 7, 567) "Error"
@assert parse_boarding_pass("FFFBBBFRRR") === (14, 7, 119)
@assert parse_boarding_pass("BBFFBBFRLL") === (102, 4, 820)

function solvepart1()
    open("input.txt") do file
        maxseatid = 0
        for boarding_pass in eachline(file)
            this = parse_boarding_pass(boarding_pass)[3]
            maxseatid = maxseatid < this ? this : maxseatid
        end
        println(maxseatid)
    end
end
# answer: 892

function solvepart2()
    open("input.txt") do file
        seatid = Set{Int}();
        for boarding_pass in eachline(file)
            this = parse_boarding_pass(boarding_pass)[3]
            push!(seatid, this)
        end
        aa = [ 8*x + y-1 for x in 1:127 for y in 1:8]
        for emptyseat in setdiff(Set(aa), seatid)
            if (emptyseat <= 892) && (emptyseat-1 in seatid) && (emptyseat+1 in seatid)
                println(emptyseat)
            end
        end
    end
end
# 625

@time solvepart1()
@time solvepart2()

