using DelimitedFiles
using BenchmarkTools

x = readdlm("data.txt")

part1(x) = @views count(x[2:end] .- x[1:end-1] .> 0)

function part2(x)
  y = @views x[1:end-2] .+ x[2:end-1] .+ x[3:end]
  part1(y)
end

@info "Day 1 Part 1"
@btime part1(x)

@info "Day 1 Part 2"
@btime part2(x)
