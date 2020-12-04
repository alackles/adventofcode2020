# Day 03: Toboggan Trajectory
# https://adventofcode.com/2020/day/3

using DelimitedFiles

# process data
# from: https://www.assertnotmagic.com/2019/05/17/julia-read-grid/
fname = "input_toboggan_trajectory.txt"
lines = readdlm(fname, '\n')
grid = map(x -> split(x, ""), lines)
grid = permutedims(hcat(grid...))

# identities
global nrows = size(grid,1)
global ncols = size(grid,2)

# count the number of trees with variable slopes
function counttrees(right, down)
    row = 1
    col = 1
    num_trees = 0
    while row <= nrows
        tree = "#"  
        if grid[row, col] == tree
            num_trees += 1
        end
        col += right
        if col > ncols
            col = col % ncols
        end
        row += down
    end
    return num_trees
end

global slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
global multitrees = 1

for m in slopes
    global multitrees *= counttrees(m[1], m[2])
end

open("pt2_toboggan_trajectory_soln.txt", "w") do f
    write(f, string(multitrees))
end