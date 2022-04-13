const DefaultTimeDateFormat = dateformat"y-m-dTH:M:S.sss"

function TimeDate(xs::NTuple{N,String}) where {N}
    zs = ntuple(a -> 0, max(0, 9 - length(xs)))
    ys = map(s -> isempty(s) ? 0 : parse(Int, s), xs)
    TimeDate(ys..., zs...)
end

function TimeDate(str::AbstractString, df::DateFormat=DefaultTimeDateFormat)
    ymdhms, subsec = ymdhms_subsec(str)
    df_ymdhms, s_count = dateformat_ymdhms(df)
    datetime = DateTime(ymdhms, df_ymdhms)
    TimeDate(datetime) + subseconds(subsec, s_count)
end

function ymdhms_subsec(str::AbstractString)
    idx = index_seconds_subsecs_sep(str)
    if isnothing(idx)
        datetime = str
        subsec = ""
    else
        datetime = str[1:idx-1]
        subsec = str[idx+1:end]
    end
    datetime, subsec
end

#=
    dateformat_ymdhms(::DateFormat)

strips any trailing 's's and their preceeding '.' or ',' , counts trailing 's's
=#
function dateformat_ymdhms(df::Dates.DateFormat)
    str = string(df)[12:end-1]
    s_count = trailing_schars(str)
    if s_count === 0
        if (str[end] === '.' || str[end] === ',')
            adjustend = 1
        else
            adjustend = 0
        end
    else
        adjustend = s_count + 1
    end
    DateFormat(str[1:end-adjustend]), s_count
end

function trailing_schars(str)
    n = length(str)
    idx = findfirst('s', str)
    isnothing(idx) && return 0
    n - idx + 1
end

#=
    subseconds(str, s_count)

converts a string of numbers into Nanosecond resolved subseconds
- *constrained by s_count, trailing 's's in dateformat*

- subseconds("01") == Millisecond(10)
- subseconds("1234") == Millisecond(123) + Microsecond(400)
- subseconds("1234", 1) == Millisecond(123) + Microsecond(0)
- subseconds("123456789") == Millisecond(123) + Microsecond(456) + Nanosecond(789)
- subseconds("12345678949456") == Millisecond(123) + Microsecond(456) + Nanosecond(789)
- subseconds("12345678949876") == Millisecond(123) + Microsecond(456) + Nanosecond(790)
=#
function subseconds(s::AbstractString, s_count=3)
    n = length(s)
    (n == 0 || s_count == 0) && return Millisecond(0)
    if n <= 3
        m = parse(Int, s) * 10^(3 - n)
        return Millisecond(m)
    elseif n <= 6
        m = parse(Int, s[1:3])
        u = parse(Int, s[4:n]) * 10^(6 - n)
        return Millisecond(m) + Microsecond(s_count > 1 ? u : 0)
    elseif n <= 9
        m = parse(Int, s[1:3])
        u = parse(Int, s[4:6])
        n = parse(Int, s[7:n]) * 10^(9 - n)
        return Millisecond(m) + Microsecond(s_count > 1 ? u : 0) + Nanosecond(s_count > 2 ? n : 0)
    else
        t = subseconds(s[1:9],3)
        n = Nanosecond(Dates.value(subseconds(s[10:end], 1)) >= 500)
        return t + n
    end
end

@inline mymax(x, y) = isnothing(x) ? y : (isnothing(y) ? x : max(x, y))

function index_seconds_subsecs_sep(str::AbstractString)
    idx1 = findlast('.', str)
    idx2 = findlast(',', str)
    mymax(idx1, idx2)
end
