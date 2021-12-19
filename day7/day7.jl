using BenchmarkTools

x = parse.(Int, split(readline("data.txt"), ','))

fuel2(n) = (n * (n + 1)) >> 1

part1(x) = minimum(sum(abs, x .- x̄) for x̄ ∈ minimum(x):maximum(x))
part2(x) = minimum(sum(fuel2.(abs.(x .- x̄))) for x̄ ∈ minimum(x):maximum(x))

@assert part1([16,1,2,0,4,2,7,1,2,14]) == 37
@assert part2([16,1,2,0,4,2,7,1,2,14]) == 168

@info "Day 7 Part 1"
@btime part1(x)

@info "Day 7 Part 2"
@btime part2(x)
