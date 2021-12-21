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
      if n == 2
        d = 1
      elseif n == 3
        d = 7
      elseif n == 4
        d = 4
      elseif n == 7
        d = 8
      elseif n == 5
        s = tuple(count_ones.(c .& d174)...)
        if s == (1, 2, 2)
          d = 2
        elseif s == (2, 3, 3)
          d = 3
        elseif s == (1, 2, 3)
          d = 5
        else
          @error "Bad digit: $d1, $d2 => $n, $s"
          continue
        end
      elseif n == 6
        s = tuple(count_ones.(c .& d174)...)
        if s == (2, 3, 3)
          d = 0
        elseif s == (1, 2, 3)
          d = 6
        elseif s == (2, 3, 4)
          d = 9
        else
          @error "Bad digit: $d1, $d2 => $n, $s"
          continue
        end
      else
        @error "Bad digit: $d1, $d2 => $n"
        continue
      end
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
