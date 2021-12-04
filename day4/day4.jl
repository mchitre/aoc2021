using BenchmarkTools

function loadboards(filename)
  open(filename) do f
    s = readlines(f)
    nos = map(x -> parse(Int, x), split(s[1], ','))
    boards = Matrix{Int}[]
    for i ∈ 3:6:length(s)
      b = Matrix{Int}(undef, 5, 5)
      for j ∈ 1:5
        b[j,:] .= map(x -> parse(Int, x), split(strip(s[i+j-1]), r" +"))
      end
      push!(boards, b)
    end
    boards, nos
  end
end

function part1(boards, nos)
  drawn = [fill(false, 5, 5) for _ ∈ boards]
  for n ∈ nos
    for (b, b̄) ∈ zip(boards, drawn)
      ndx = findfirst(==(n), b)
      if ndx !== nothing
        b̄[ndx] = true
        (any(sum(b̄; dims=1) .== 5) || any(sum(b̄; dims=2) .== 5)) && return sum(b[.!(b̄)]) * n
      end
    end
  end
end

function part2(boards, nos)
  drawn = [fill(false, 5, 5) for _ ∈ boards]
  inplay = collect(1:length(boards))
  for n ∈ nos
    next = Int[]
    for i ∈ inplay
      b = boards[i]
      b̄ = drawn[i]
      ndx = findfirst(==(n), b)
      if ndx !== nothing
        b̄[ndx] = true
        if any(sum(b̄; dims=1) .== 5) || any(sum(b̄; dims=2) .== 5)
          length(inplay) == 1 && return sum(b[.!(b̄)]) * n
          continue
        end
      end
      push!(next, i)
    end
    inplay = next
  end
end

x = loadboards("test.txt")

@assert part1(x...) == 4512
@assert part2(x...) == 1924

x = loadboards("data.txt")

@info "Day 4 Part 1"
@btime part1(x...)

@info "Day 4 Part 2"
@btime part2(x...)
