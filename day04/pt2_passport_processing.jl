# Day 4

# Named Arrays: https://github.com/davidavdav/NamedArrays.jl
using NamedArrays

# first just standardize the passport format 
# read the file one line at a time
fname = "input_passport_processing.txt"
global passports = []

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
            push!(passports, temp_dict)
            temp_dict = Dict{String,String}()
        end
    end
end

# now that we have passports in a standardized format 
# we can process them one at a time
global req_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
global nvalid = 0


# originally was using and statements
# inspired by https://github.com/goggle/AdventOfCode2020.jl/blob/master/src/day04/day04.jl
# against whom i have also checked my regexes
# so I'm trying that now
for port in passports
    if !haskey(port, "byr") || !(1920 <= parse(Int, port["byr"]) <= 2002) 
        continue
    elseif !haskey(port, "iyr") || !(2010 <= parse(Int, port["iyr"]) <= 2020)
        continue
    elseif !haskey(port, "eyr") || !(2020 <= parse(Int, port["eyr"]) <= 2030)
        continue
    elseif !haskey(port, "hgt") || !occursin(r"^\d+(cm|in)", port["hgt"]) 
        continue
    elseif occursin(r"^\d+cm", port["hgt"]) && !(150 <= parse(Int, chop(port["hgt"], tail=2)) <= 193)
        continue
    elseif occursin(r"^\d+in", port["hgt"]) && !(59 <= parse(Int, chop(port["hgt"], tail=2)) <= 76)
        continue
    elseif !haskey(port, "hcl") || !occursin(r"^\#[0-9a-f]{6}", port["hcl"])
        continue
    elseif !haskey(port, "ecl") || !occursin(r"^(amb|blu|brn|gry|grn|hzl|oth)$", port["ecl"])
        continue
    elseif !haskey(port, "pid") || !occursin(r"^\d{9}$", port["pid"])
        continue
    else
        global nvalid += 1
    end
end

@show nvalid

open("pt2_passport_processing_soln.txt", "w") do f
    write(f, string(nvalid))
end