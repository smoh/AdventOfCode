n = parse.(Int, readlines("input.txt"))
push!(n, 0, max(n...)+3)
n = sort(n)
d = n[2:end] - n[1:end-1]
count =  Dict([(i, sum(d .== i)) for i in unique(d)])
println(count)
# part 1
println("$(count[1] * count[3])")

println(n[1:15])
println(d[1:15])


# part 2
# if the difference to the next number (increasing) is 3,
# the two numbers have to exist in the adapter chain.
# The free part of adapter chain is how to combine consecutive 1's
# so that it sums to next "anchor"
#
# Two 1's = 1 + 1 = 2 (two ways)
# Three 1's = 1 + 1 + 1 = 2 + 1 = 1 + 2 = 3 (four ways)
# similarly four 1's have 7 ways
# 
# This puzzle contains at most consecutive 4 ones.


# crappy way of counting consecutive 1's between 3's
x = []
c = 0
for k in d
  if (k == 1)
    c+=1
  elseif (k == 3)
    println(c)
    if c != 0     # ignore consecutive 3's
      push!(x, c)
    end
    global c = 0
  end
end

println(x)


# 

y = []
for m in x
  if m == 1
    push!(y, 1)
  elseif m == 2
    push!(y, 2)
  elseif m == 3
    push!(y, 4)
  elseif m == 4
    push!(y, 7)
  end
end

# part2 answer
println(prod(y))




