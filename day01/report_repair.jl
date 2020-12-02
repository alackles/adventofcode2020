using DelimitedFiles

expense_report = readdlm("input_report_repair.csv", ',', Int)

ind = 2
val1 = 0
val2 = 0
prod = 0

for i in expense_report
   for j in expense_report[ind:end]
        if i + j == 2020
            global val1 = i
            global val2 = j
            global prod = i*j
        end
    end
    global ind += 1
end

println(val1)
println(val2)
println(prod)