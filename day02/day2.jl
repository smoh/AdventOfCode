### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 689b3230-348c-11eb-05d4-d5c4843afde3
data = readlines("input.txt")

# ╔═╡ 7e3fea5e-348c-11eb-20ad-5bd57d4e02e8
typeof(data[1])

# ╔═╡ bf651428-348c-11eb-2d0d-f9e4fb37e6eb
policy_pw = split.(data, ":")

# ╔═╡ 2f84403a-348d-11eb-07f0-c9d60a6017b5
function parse_data(s)
	(policy, pw) = split(s, ":")
	pw = pw[2:end]
	(numbers, chkchar) = split(policy, " ")
	(min_, max_) = parse.(Int, split(numbers, "-"))
	return Char(chkchar[1]), min_, max_, pw
end

# ╔═╡ 32dc91ce-348d-11eb-1205-bb064e77fb14
(chkchar, min_, max_, pw) = parse_data(data[1])

# ╔═╡ 9463f9bc-348f-11eb-3f0b-2982b7ada3ad
collect(pw)

# ╔═╡ db0d6524-348f-11eb-271e-f58b41279ae2
typeof(collect(pw))

# ╔═╡ df3ae8ec-348f-11eb-0970-815192c7a3fd
sum(collect(pw) .== chkchar)

# ╔═╡ 49db1dd4-3490-11eb-3f36-317cddce38f1
Char(chkchar[1])

# ╔═╡ 318555c4-3490-11eb-03f4-3531f50efa09
let
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

# ╔═╡ 0163bd8a-3491-11eb-1e3c-831b0452ca61
let
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

# ╔═╡ Cell order:
# ╠═689b3230-348c-11eb-05d4-d5c4843afde3
# ╠═7e3fea5e-348c-11eb-20ad-5bd57d4e02e8
# ╠═bf651428-348c-11eb-2d0d-f9e4fb37e6eb
# ╠═2f84403a-348d-11eb-07f0-c9d60a6017b5
# ╠═32dc91ce-348d-11eb-1205-bb064e77fb14
# ╠═9463f9bc-348f-11eb-3f0b-2982b7ada3ad
# ╠═db0d6524-348f-11eb-271e-f58b41279ae2
# ╠═df3ae8ec-348f-11eb-0970-815192c7a3fd
# ╠═49db1dd4-3490-11eb-3f36-317cddce38f1
# ╠═318555c4-3490-11eb-03f4-3531f50efa09
# ╠═0163bd8a-3491-11eb-1e3c-831b0452ca61
