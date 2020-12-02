### A Pluto.jl notebook ###
# v0.12.15

using BenchmarkTools

data = readlines("input.txt")

function parse_data(s)
	(policy, pw) = split(s, ":")
	pw = pw[2:end]
	(numbers, chkchar) = split(policy, " ")
	(min_, max_) = parse.(Int, split(numbers, "-"))
	return Char(chkchar[1]), min_, max_, pw
end

function solve1()
	count = 0
	for (chkchar, min_, max_, pw) in parse_data.(data)
		count_char = sum(collect(pw) .== chkchar)
		if (count_char >= min_) & (count_char <= max_)
			count += 1
		end
	end
	println("part 1 answer: ", count)
	count
end

function solve2()
	count2 = 0
	for (chkchar, min_, max_, pw) in parse_data.(data)
		a = pw[min_] == chkchar
		b = pw[max_] == chkchar
		if (a & ~b) | (~a & b)
			count2 += 1
		end
	end
	println("part 2 answer: ", count2)
	count2
end

@time solve1()
@time solve2()