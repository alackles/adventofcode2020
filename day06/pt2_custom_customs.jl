
# first read in the data
# this time we need to save the number of lines too
fname = "input_custom_customs.txt"
global entries = []

open(fname) do file
    temp_array = Array{String,1}()
    linecount = 0
    for line in eachline(file)
        if !isempty(line)
            splitline = split(chomp(line), "")
            temp_array = [temp_array ; splitline]
            linecount += 1
            if eof(file)
                push!(entries, (temp_array, linecount))
            end
        else
            push!(entries, (temp_array, linecount))
            temp_array = Array{String, 1}()
            linecount = 0
        end
    end
end


# Now find the actual answer

global sumcount = 0

for (entry, lines) in entries
    for ans in unique(entry)
        global sumcount += (lines == count(i->(i==ans), entry))
    end
end


open("pt2_custom_customs_soln.txt", "w") do f
    write(f, string(sumcount))
end