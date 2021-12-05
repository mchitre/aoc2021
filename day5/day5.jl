using BenchmarkTools
using OffsetArrays

function loaddata(filename)
  mapreduce(hcat, readlines(filename)) do s
    f = split(s, r"[^\d]+")
    @assert length(f) == 4
    parse.(Int, f)
  end |> transpose
end

function part1(lines)
  xmin, xmax = extrema(vcat(lines[:,1], lines[:,3]))
  ymin, ymax = extrema(vcat(lines[:,2], lines[:,4]))
  M = OffsetArray(zeros(Int, ymax - ymin + 1, xmax - xmin + 1), ymin:ymax, xmin:xmax)
  for l ∈ eachrow(lines)
    if l[1] == l[3]
      M[l[2]:sign(l[4]-l[2]):l[4],l[1]] .+= 1
    elseif l[2] == l[4]
      M[l[2],l[1]:sign(l[3]-l[1]):l[3]] .+= 1
    end
  end
  count(M .> 1)
end

function part2(lines)
  xmin, xmax = extrema(vcat(lines[:,1], lines[:,3]))
  ymin, ymax = extrema(vcat(lines[:,2], lines[:,4]))
  M = OffsetArray(zeros(Int, ymax - ymin + 1, xmax - xmin + 1), ymin:ymax, xmin:xmax)
  for l ∈ eachrow(lines)
    if l[1] == l[3]
      M[l[2]:sign(l[4]-l[2]):l[4],l[1]] .+= 1
    elseif l[2] == l[4]
      M[l[2],l[1]:sign(l[3]-l[1]):l[3]] .+= 1
    else
      for (i, j) ∈ zip(l[2]:sign(l[4]-l[2]):l[4], l[1]:sign(l[3]-l[1]):l[3])
        M[i,j] += 1
      end
    end
  end
  count(M .> 1)
end

x = loaddata("test.txt")

@assert part1(x) == 5
@assert part2(x) == 12

x = loaddata("data.txt")

@info "Day 5 Part 1"
@btime part1(x)

@info "Day 5 Part 2"
@btime part2(x)
