using BenchmarkTools

function load(filename)
  data = Tuple{Vector{String},Vector{String}}[]
  for s ∈ readlines(filename)
    s1, s2 = split(s, " | ")
    push!(data, (split(s1, ' '), split(s2, ' ')))
  end
  data
end

part1(data) = let set = Set([2,3,4,7])
  sum(count(∈(set), length.(x2)) for (x1, x2) ∈ data)
end

function part2(data)
  code(s) = |([1 << (c - 'a') for c ∈ s]...)
  lut = Dict{Union{Int,NTuple{4,Int}},Int}(
    2 => 1,
    3 => 7,
    4 => 4,
    7 => 8,
    (5, 1, 2, 2) => 2,
    (5, 2, 3, 3) => 3,
    (5, 1, 2, 3) => 5,
    (6, 2, 3, 3) => 0,
    (6, 1, 2, 3) => 6,
    (6, 2, 3, 4) => 9
  )
  sum_reading = 0
  for (d1, d2) ∈ data
    d1codes = code.(d1)
    d2codes = code.(d2)
    codes = unique(vcat(d1codes, d2codes))
    counts = count_ones.(codes)
    d174 = [codes[findfirst(==(i), counts)] for i ∈ 2:4]
    reading = 0
    for c ∈ d2codes
      n = count_ones(c)
      d = n ∈ keys(lut) ? lut[n] : lut[tuple(n, count_ones.(c .& d174)...)]
      reading = reading * 10 + d
    end
    sum_reading += reading
  end
  sum_reading
end

@assert part1(load("test.txt")) == 26
@assert part2(load("test.txt")) == 61229

data = load("data.txt")

@info "Day 8 Part 1"
@btime part1(data)

@info "Day 8 Part 2"
@btime part2(data)
