using Dates
using Dates: value, tons
using DatesWithNanoseconds
using DatesWithNanoseconds: NanosecondsPerMillisecond, NanosecondsPerDay, MicrosecondsPerDay
using Test

milliseconds(x::TimeDate) = fld(value(x), NanosecondsPerMillisecond)
milliseconds(x::TimeDate, ::RoundingMode{:Down}) = fld(value(x), NanosecondsPerMillisecond)
milliseconds(x::TimeDate, ::RoundingMode{:Up}) = cld(value(x), NanosecondsPerMillisecond)
# for the general case, these must use Int128s (for these tests, it is not needed)
nanoseconds(x::TimeDate) = value(x)
nanoseconds(x::DateTime) = value(x) * NanosecondsPerMillisecond

include("testvalues.jl")
include("timedate.jl")
include("basefuncs.jl")
include("accessors.jl")
include("compare.jl")
include("datesfuncs.jl")
include("arithmetic.jl")
include("rounding.jl")
include("parsing.jl")
include("ranges.jl")
include("namedtuples.jl")
