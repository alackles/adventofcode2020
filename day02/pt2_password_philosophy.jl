# Find how many passwords are valid

using DelimitedFiles

infile = "input_password_philosophy.csv"
pwords = readdlm(infile, ',')

global valid_pw_count = 0

function validate_pw(pwline)

    # parse the line to validate it
    pw = split(pwline) # array: [min-max alph: password]
    pos1 = parse(Int, split(pw[1],"-")[1])
    pos2 = parse(Int, split(pw[1],"-")[2])
    alph = split(pw[2],":")[1]
    pass = split(pw[3],"")
    
    #check for validity
    return xor(pass[pos1] == alph, pass[pos2] == alph)
end

for pw in pwords
    global valid_pw_count += validate_pw(pw)
end

open("pt2_password_philosophy_soln.txt", "w") do f
    write(f, string(valid_pw_count))
end


