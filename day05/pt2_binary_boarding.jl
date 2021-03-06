
using DelimitedFiles

# process data
# from: https://www.assertnotmagic.com/2019/05/17/julia-read-grid/
fname = "input_binary_boarding.txt"
passes = readdlm(fname, '\n')

global max_ID = 0
global firstcol = 1
global lastcol = 8
global firstrow = 1
global lastrow = 128

global seatlist = []

function bisectparse(strname, min, max, lower, upper)
    bounds = min:max
    strlen = length(strname)
    for (index, val) in enumerate(strname)
        if index < strlen 
            if val == lower
                newbound = convert(Int, length(bounds)/2)
                bounds = bounds[1:newbound]
            elseif val == upper
                newbound = convert(Int, length(bounds)/2 + 1)
                bounds = bounds[newbound:end]
            end
        elseif index == strlen
            if strname[end] == lower
                return bounds[1]
            elseif strname[end] == upper
               return bounds[2]
        
            end
        end
    end
end

for pass in passes
    rowname = pass[1:7]
    colname = pass[8:end]
    row = bisectparse(rowname, firstrow, lastrow, 'F', 'B')
    col = bisectparse(colname, firstcol, lastcol, 'L', 'R')
    seat_ID = (row - 1)*8 + (col-1)
    push!(seatlist, seat_ID)
end

function findmyseat(seatlist)

    for seat in sort(seatlist)
        if seat + 1 in seatlist
            continue
        else
            return seat + 1
        end
    end
end


open("pt2_binary_boarding_soln.txt", "w") do f
    write(f, string(findmyseat(seatlist)))
end
