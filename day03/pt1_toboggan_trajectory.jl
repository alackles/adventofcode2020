# Day 03: Toboggan Trajectory
# https://adventofcode.com/2020/day/3

using DelimitedFiles

# process data
# from: https://www.assertnotmagic.com/2019/05/17/julia-read-grid/
fname = "input_toboggan_trajectory.txt"
lines = readdlm(fname, '\n')
grid = map(x -> split(x, ""), lines)
grid = permutedims(hcat(grid...))

#counters
global row = 1
global col = 1
global num_trees = 0

# identities
global nrows = size(grid,1)
global ncols = size(grid,2)

while row <= nrows
    tree = "#"
    if grid[row, col] == tree
        global num_trees += 1
    end
    global col += 3
    if col > ncols
        col = col % ncols
    end
    global row += 1
end

open("pt1_toboggan_trajectory_soln.txt", "w") do f
    write(f, string(num_trees))
end