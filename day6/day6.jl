using BenchmarkTools

function nfish(ages, ndays)
  count = zeros(Int, 9)
  for a ∈ ages
    count[a+1] += 1
  end
  z = 1
  for i ∈ 1:ndays
    n = count[z]
    z = mod1(z+1, 9)
    count[mod1(z+6, 9)] += n
  end
  sum(count)
end

@assert nfish([3,4,3,1,2], 18) == 26
@assert nfish([3,4,3,1,2], 80) == 5934
@assert nfish([3,4,3,1,2], 256) == 26984457539

x = parse.(Int, split(readline("data.txt"), ','))

@info "Day 5 Part 1"
@btime nfish(x, 80)

@info "Day 5 Part 2"
@btime nfish(x, 256)
