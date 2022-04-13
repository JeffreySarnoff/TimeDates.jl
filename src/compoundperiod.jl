
# enhancing CompoundPeriod

Dates.Nanosecond(x::CompoundPeriod) =
    sum(Nanosecond.(x.periods))

Dates.Millisecond(x::CompoundPeriod) =
    sum(Millisecond.(x.periods))

Base.zero(x::CompoundPeriod) =
    canonicalize(Day(0) + Nanosecond(0))

Base.isempty(x::CompoundPeriod) = x.periods == Period[]

Base.:(*)(x::Integer, y::CompoundPeriod) = sum(x .* y.periods)
Base.:(*)(x::CompoundPeriod, y::Integer) = y * x

function Base.abs(x::CompoundPeriod)
    !signbit(x) && return x
    sum(-1 .* x.periods)
end

Base.signbit(x::Period) = signbit(x.value)
Base.signbit(x::CompoundPeriod) = signbit(x.periods[1].value)
Base.sign(x::CompoundPeriod) = sign(x.periods[1].value)

# Dates.tons(::CompoundPeriod) !! May Overflow 
Dates.tons(x::Dates.CompoundPeriod) = Int64(tonanos(x))

function tonanos(x::Dates.CompoundPeriod)
    bignanos = Int128.(tons.(x.periods))
    nanos128 = sum(bignanos)
    nanos64 = nanos128 % Int64
    nanos128 == nanos64 ? nanos64 : nanos128
end

Dates.value(x::Dates.CompoundPeriod) = tonanos(x)

# to milliseconds
Dates.toms(x::Dates.CompoundPeriod) =
    sum(Dates.toms.(x.periods))

# iterator for CompoundPeriod (needed with range step)
Base.iterate(x::CompoundPeriod) = iterate(x.periods)
Base.iterate(x::CompoundPeriod, state) = iterate(x.periods, state)
