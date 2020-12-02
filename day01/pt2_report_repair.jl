module report_repair2

using DelimitedFiles

expense_report = readdlm("input_report_repair.csv", ',', Int)

function triple_add(values)

    ind = 2
    first_pass = Array{Int64}(undef, 0, 2)

    for i in expense_report
        for j in expense_report[ind:end]
            if i + j < 2020
                first_pass = [first_pass; i j]
            end
        end
    ind += 1
    end

    for row in eachrow(first_pass)
        for val in expense_report
            if sum(row) + val == 2020
                #println(row)
                #println(val)
                return prod(row) * val
            end
        end
    end
end

open("pt2_report_repair_soln.txt", "w") do f
    write(f, string(triple_add(expense_report)))
end

end