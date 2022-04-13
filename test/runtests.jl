using Dates
using Dates: value, tons
using TimeDates
using TimeDates: NanosecondsPerMillisecond, NanosecondsPerDay, MicrosecondsPerDay
using Test

milliseconds(x::TimeDate) = fld(Dates.value(x), NanosecondsPerMillisecond)
milliseconds(x::TimeDate, ::RoundingMode{:Down}) = fld(Dates.value(x), NanosecondsPerMillisecond)
milliseconds(x::TimeDate, ::RoundingMode{:Up}) = cld(Dates.value(x), NanosecondsPerMillisecond)
milliseconds(x::DateTime) = Dates.value(x)
milliseconds(x::Date) = milliseconds(DateTime(x))
# for the general case, these must use Int128s (for these tests, it is not needed)
nanoseconds(x::TimeDate) = Dates.value(x)
nanoseconds(x::DateTime) = Dates.value(x) * NanosecondsPerMillisecond
nanoseconds(x::Date) = nanoseconds(DateTime(x))

include("testvalues.jl")
include("timedate.jl")
include("basefuncs.jl")
include("accessors.jl")
include("compare.jl")
include("datesfuncs.jl")
include("arithmetic.jl")
include("rounding.jl")
include("parsing.jl")
include("compoundperiods.jl")
include("ranges.jl")
include("namedtuples.jl")
