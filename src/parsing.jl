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
    hms, subsecs, T = timeseparate(timestr)
    time = Time(hms) + T(parse(Int,subsecs))
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
const SubsecType = (Millisecond, Microsecond, Nanosecond)

function timeseparate(s::AbstractString)
    idxpoint = findfirst(eqpoint, s)
    isnothing(idxpoint) && return (s, "000", Millisecond)
    hms, subsecs = split(s, '.')
    n = length(subsecs)
    subsecs = subsecs * FillZeros[3 - mod(n,3)]
    n = div(length(subsecs), 3)
    T = SubsecType[n]
    hms, subsecs, T
end
