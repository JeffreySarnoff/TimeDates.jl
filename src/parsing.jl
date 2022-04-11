function TimeDate(xs::NTuple{N,String}) where {N}
    zs = ntuple(a -> 0, max(0, 9 - length(xs)))
    ys = map(s -> isempty(s) ? 0 : parse(Int, s), xs)
    TimeDate(ys..., zs...)
end

function TimeDate(s::AbstractString)
    s = strip(s)
    datestr, timestr = separate(s)
    date = Date(rstrip(datestr))
    timestr = lstrip(timestr)
    hms, subsecs = timeseparate(timestr)
    subseconds = timesubsecs(subsecs)
    time = Time(hms) + subseconds
    TimeDate(time, date)
end

eqT(x) = x === 'T'
eqspace(x) = x === ' '
eqpoint(x) = x === '.'

function separatorchar(s::AbstractString)
    if any(eqT, s)
        return 'T'
    elseif any(eqspace, s)
        return ' '
    end
    nothing
end

function separate(s::AbstractString)
    ch = separatorchar(s)
    isnothing(ch) && return s, ""
    split(s, ch)
end

const FillZeros = ("00", "0", "",)

function timeseparate(s::AbstractString)
    idxpoint = findfirst(eqpoint, s)
    isnothing(idxpoint) && return (s, "000", Millisecond)
    hms, subsecs = split(s, '.')
    n = length(subsecs)
    subsecs = subsecs * FillZeros[3 - mod(n,3)]
    hms, subsecs
end

function timesubsecs(s::AbstractString)
    n = length(s)
    n == 0 && return Millisecond(0)
    if n <= 3
        m = parse(Int, s) * 10^(3 - n)
        return Millisecond(m)
    elseif n <= 6
        m = parse(Int, s[1:3])
        u = parse(Int, s[4:n]) * 10^(6 - n)
        return Millisecond(m) + Microsecond(u)
    else
        n = min(n, 9)
        m = parse(Int, s[1:3])
        u = parse(Int, s[4:6])
        n = parse(Int, s[7:n]) * 10^(9 - n)
        return Millisecond(m) + Microsecond(u) + Nanosecond(n)
    end
end
