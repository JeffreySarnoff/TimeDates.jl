
# enhancing CompoundPeriod

Dates.Nanosecond(x::CompoundPeriod) =
    sum(Nanosecond.(x.periods))

Dates.Millisecond(x::CompoundPeriod) =
    sum(Millisecond.(x.periods))

Base.zero(x::CompoundPeriod) =
    canonicalize(Day(0) + Nanosecond(0))

Base.isempty(x::CompoundPeriod) = x.periods == Period[]

Base.:(*)(x::CompoundPeriod, y::Integer) =
    sum(y .* x.periods)

function Base.abs(x::CompoundPeriod)
    !signbit(x) && return x
    sum(-1 .* x.periods)
end

Base.signbit(x::Period) = signbit(x.value)
Base.signbit(x::CompoundPeriod) = isempty(x) ? true : signbit(x.periods[1].value)
Base.sign(x::CompoundPeriod) = isempty(x) ? 0 : sign(x.periods[1].value)

# Dates.tons(::CompoundPeriod) !! May Overflow 
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
