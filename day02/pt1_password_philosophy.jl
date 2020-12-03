# Find how many passwords are valid

using DelimitedFiles

infile = "input_password_philosophy.csv"
pwords = readdlm(infile, ',')

global valid_pw_count = 0

function validate_pw(pwline)

    # parse the line to validate it
    pw = split(pwline) # array: [min-max alph: password]
    min = parse(Int, split(pw[1],"-")[1])
    max = parse(Int, split(pw[1],"-")[2])
    alph = split(pw[2],":")[1]
    pass = pw[3]
    # now check if really valid
    charcount = count(i->(i==alph), split(pass,""))
    return (charcount >= min) && (charcount <= max)

end

for pw in pwords
    global valid_pw_count += validate_pw(pw)
end

open("pt1_password_philosophy_soln.txt", "w") do f
    write(f, string(valid_pw_count))
end


