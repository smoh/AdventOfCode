### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 33397b16-33f5-11eb-3732-13ddfc6288ac
d = readlines("input.txt")

# ╔═╡ e51b29d8-33f5-11eb-32bb-d3b938c70c42
typeof(d)

# ╔═╡ ed99344c-33f5-11eb-120c-fd37edafc269
parse(Int, d[1])

# ╔═╡ 9b306d28-33f6-11eb-332a-93bbd0eb567f
dd = parse.(Int, d)

# ╔═╡ 2d72c176-33f6-11eb-01a8-eb4657822097
length(dd)

# ╔═╡ 5c599c30-33fd-11eb-3a1d-b9e6ac04c02a
md"part 1: What is the product of two numbers that sum to 2020?"

# ╔═╡ 80be6e26-33f7-11eb-00b3-15bf5e45ca15
let
	output = nothing
	for i in eachindex(dd)
		for j in 1:1:i
			if dd[i] + dd[j] === 2020
				output = md"output: $(dd[i]) $(dd[j]) product: $(dd[i]*dd[j])"
			end
		end
	end
	output
end

# ╔═╡ 496fa382-33fd-11eb-0fad-63dbba151070
md"part 2: What is the product of three numbers that sum to 2020?"

# ╔═╡ 7d73e0e8-33fc-11eb-0395-91fb8962de3a
let
	output = nothing
	for i in eachindex(dd)
		for j in 1:1:i
			for k in 1:1:j
				if dd[i] + dd[j] + dd[k] === 2020
					output = md"output: $(dd[i]) $(dd[j]) $(dd[k]) product: $(dd[i]*dd[j]*dd[k])"
				end
			end
		end
	end
	output
end

# ╔═╡ Cell order:
# ╠═33397b16-33f5-11eb-3732-13ddfc6288ac
# ╠═e51b29d8-33f5-11eb-32bb-d3b938c70c42
# ╠═ed99344c-33f5-11eb-120c-fd37edafc269
# ╠═9b306d28-33f6-11eb-332a-93bbd0eb567f
# ╠═2d72c176-33f6-11eb-01a8-eb4657822097
# ╟─5c599c30-33fd-11eb-3a1d-b9e6ac04c02a
# ╠═80be6e26-33f7-11eb-00b3-15bf5e45ca15
# ╟─496fa382-33fd-11eb-0fad-63dbba151070
# ╠═7d73e0e8-33fc-11eb-0395-91fb8962de3a
