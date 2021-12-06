using BenchmarkTools
using OffsetArrays

function part1(ages, ndays)
  count = OffsetArray(zeros(Int, 9), 0:8)
  for a ∈ ages
    count[a] += 1
  end
  for i ∈ 1:ndays
    n = count[0]
    count[0:7] .= count[1:8]
    count[8] = n
    count[6] += n
  end
  sum(count)
end

@assert part1([3,4,3,1,2], 18) == 26
@assert part1([3,4,3,1,2], 80) == 5934
@assert part1([3,4,3,1,2], 256) == 26984457539

x = parse.(Int, split(readline("data.txt"), ','))

@info "Day 5 Part 1"
@btime part1(x, 80)

@info "Day 5 Part 2"
@btime part1(x, 256)
