# Day 4

# Named Arrays: https://github.com/davidavdav/NamedArrays.jl
using NamedArrays

# first just standardize the passport format 
# read the file one line at a time
fname = "input_passport_processing.txt"
global passports = []
global temp_string = ""

open(fname) do file
    for line in eachline(file)
        line = chomp(line)
        if eof(file)
            global temp_string = temp_string * " " * line
            global passports = push!(passports, lstrip(temp_string))
        elseif isempty(line)
            global passports = push!(passports, lstrip(temp_string))
            global temp_string = ""
        else
            global temp_string = temp_string * " " * line
        end
    end
end
# now that we have passports in a standardized format 
# we can process them one at a time

req_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

nvalid = 0


for port in passports
    nfields = 0
    fields = split(port, " ")
    for field in fields
        label = field[1:3]
        if label in req_fields
            nfields += 1
        end
    end
    if nfields == 7 
        global nvalid += 1
    end
end

open("p12_passport_processing_soln.txt", "w") do f
    write(f, string(nvalid))
end