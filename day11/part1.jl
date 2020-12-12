lines = readlines("input.txt")


# x = collect.(lines)

x = reduce(vcat, permutedims.(collect.(lines)))

# xprev = copy(x)
# xprev[:] = '.'


# x = Array{Char, 2}(undef, nrow, ncol)

# while( (i==0) && (x!= xnext) )


function flip(x)
    nrow, ncol = size(x)
    xnext = copy(x)
    for irow in 1:nrow
        for icol in 1:ncol
            if x[irow, icol] == '.'
                xnext[irow, icol] ='.'
            else
                ii = setdiff(
                    Set(CartesianIndices(
                        (max(1, irow-1):min(nrow,irow+1), max(1, icol-1):min(ncol,icol+1)))),
                    [CartesianIndex(irow, icol)])
                d = []
                for j in Iterators.Stateful(ii)
                    push!(d, x[j])
                end
                # d = [x[jj] for jj in Iterators.Stateful(ii)]
                count =  Dict([(k, sum(d .== k)) for k in unique(d)]) 
                for ch in ['.','#','L']
                    if !(ch in keys(count))
                        count[ch] = 0
                    end
                end
                if (x[irow,icol] == 'L') && (count['L'] == length(ii) - ('.' in keys(count) ? count['.'] : 0))
                    xnext[irow, icol] = '#'
                elseif (x[irow, icol] == '#') && (count['#'] >= 4)
                    xnext[irow, icol] = 'L'
                end
            end
        end
    end
    xnext
end



i = 0
xnext = copy(x)
while ((i==0) || (xnext != x))
    global x = xnext
    global xnext = flip(xnext)
    global i += 1
end
println("seating finished")
println(i)
println(sum(xnext .== '#'))
