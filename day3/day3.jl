using BenchmarkTools

x = open("data.txt") do f
  readlines(f)
end

function part1(x)
  n = length(x) ÷ 2
  b = length(first(x))
  γ = 0
  ϵ = 0
  for i ∈ eachindex(first(x))
    if count(x1[i] .== '1' for x1 ∈ x) > n
      γ |= 1 << (b - i)
    else
      ϵ |= 1 << (b - i)
    end
  end
  γ * ϵ
end

function part2a(x, f)
  x = copy(x)
  i = 1
  while length(x) > 1
    m = count(x1[i] .== '1' for x1 ∈ x)
    b = f(m, length(x) - m) ? '1' : '0'
    filter!(x1 -> x1[i] == b, x)
    i += 1
  end
  parse(Int, only(x); base=2)
end

part2(x) = part2a(x, ≥) * part2a(x, <)

@info "Day 3 Part 1"
@btime part1(x)

@info "Day 3 Part 2"
@btime part2(x)
