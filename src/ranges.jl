# TimeDate specific, adapted from of Dates/src/ranges.jl

Dates.guess(a::TimeDate,b::TimeDate,c) =
     floor(Int64, (Int128(Dates.value(b)) - Int128(Dates.value(a))) / Dates.tons(c))

function Base.StepRange{TimeDate,CompoundPeriod}(start, step, stop)
    Base.StepRange{TimeDate, Nanosecond}(start, Nanosecond(step), stop)
end

function Base.StepRange{DateTime,CompoundPeriod}(start, step, stop)
    Base.StepRange{DateTime, Nanosecond}(start, Nanosecond(step), stop)
end
