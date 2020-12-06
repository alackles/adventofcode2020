
# first read in the data
fname = "test_custom_customs.txt"
global entries = []

open(fname) do file
    temp_array = Array{String, 1}()
    for line in eachline(file)
        if !isempty(line)
            splitline = split(chomp(line),"")
            temp_array = [temp_array ; splitline]
            if eof(file)
                push!(entries,temp_array)
            end
        else
            push!(entries, temp_array)
            temp_array = Array{String, 1}()
        end
    end
end


@show entries