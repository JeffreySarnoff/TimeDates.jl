Base.iszero(x::Time) = x === Time0

Base.eps(::TimeDate) = Nanosecond(1)
Base.typemax(::Type{TimeDate}) = TimeDate(typemax(DateTime))
Base.typemin(::Type{TimeDate}) = TimeDate(typemin(DateTime))

function Base.hash(x::TimeDate, h::UInt64)
    h = hash(x.time.instant, h)
    h = hash(x.date.instant.periods, h)
    return h
end

Base.string(x::TimeDate) = string(x.date, "T", x.time)

Base.show(io::IO, x::TimeDate) = print(io, string(x))
Base.repr(x::TimeDate) = "TimeDate(\"" * string(x) * "\")"
