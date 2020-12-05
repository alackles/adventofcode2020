# Day 4

# Named Arrays: https://github.com/davidavdav/NamedArrays.jl
using NamedArrays

# first just standardize the passport format 
# read the file one line at a time
fname = "test_passport_processing.txt"
global passports = []
@show typeof(passports)
@show passports

open(fname) do file
    temp_dict = Dict{String,String}()
    for line in eachline(file)
        if !isempty(line)
            splitline = split(chomp(line), " ")
            for entry in splitline
                (key, value) = split(entry, ":")
                temp_dict[key] = value
            end
            if eof(file)
                push!(passports, temp_dict)
            end
        else
            @show temp_dict
            push!(passports, temp_dict)
            temp_dict = Dict{String,String}()
        end
    end
end

@show passports
# now that we have passports in a standardized format 
# we can process them one at a time
#=
req_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

nvalid = 0


for port in passports
    nfields = 0
    fields = split(port, " ")
    for field in fields
        keyval = split(field, ":")
        label = keyval[1]
        data = keyval[2]
        if label == "byr" && parse(Int64, data) >= 1920 && parse(Int64, data) <= 2002
            nfields += 1
                
        elseif label == "iyr" && parse(Int64, data) >= 2010 && parse(Int64, data) <= 2020
            nfields += 1
        
        elseif label == "eyr" && parse(Int64, data) >= 2020 && parse(Int64, data) <= 2030
            nfields += 1

        elseif label == "hgt" && occursin(r"^\d+(cm|in)", data)
            num_only = parse(Int64, chop(data, tail = 2))
            if endswith(data, "cm")
                if num_only >= 150 && num_only <= 193
                    nfields += 1
                end
            elseif endswith(data, "in")
                if num_only >= 59 && num_only <= 76
                    nfields += 1
                end
            end
        
        elseif label == "hcl" && occursin(r"^\#[0-9a-f]{6}", data)
            nfields += 1
        
        elseif label == "ecl" && (data in ["amb", "blu", "brn","gry", "grn","hzl","oth"])
            nfields += 1
        
        elseif label == "pid" && occursin(r"^\d{9}", data)
            nfields += 1
        end
    end
    if nfields == 7 
        global nvalid += 1
    end
end

open("pt2_passport_processing_soln.txt", "w") do f
    write(f, string(nvalid))
end =#