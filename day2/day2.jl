using BenchmarkTools

x = open("data.txt") do f
  readlines(f)
end

function part1(cmds)
  x = 0
  z = 0
  for c ∈ cmds
    if startswith(c, "forward ")
      x += parse(Int, c[9:end])
    elseif startswith(c, "down ")
      z += parse(Int, c[5:end])
    elseif startswith(c, "up ")
      z -= parse(Int, c[4:end])
    end
  end
  x * z
end

function part2(cmds)
  x = 0
  z = 0
  aim = 0
  for c ∈ cmds
    if startswith(c, "forward ")
      n = parse(Int, c[9:end])
      x += n
      z += aim * n
    elseif startswith(c, "down ")
      aim += parse(Int, c[5:end])
    elseif startswith(c, "up ")
      aim -= parse(Int, c[4:end])
    end
  end
  x * z
end

@info "Day 2 Part 1"
@btime part1(x)

@info "Day 2 Part 2"
@btime part2(x)
