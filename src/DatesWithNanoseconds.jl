module DatesWithNanoseconds

export TimeDate, periods, timedate2rata, rata2timedate

using Dates
using Dates: AbstractDateTime, CompoundPeriod, value, days, tons, toms

include("constants.jl")
include("timedate.jl")
include("basefuncs.jl")
include("accessors.jl")
include("compare.jl")
include("datesfuncs.jl")
include("arithmetic.jl")
include("rounding.jl")
include("parsing.jl")
include("compoundperiod.jl")
include("ranges.jl")            # with CompoundPeriod steps
include("namedtuples.jl")       # alternative representation using NamedTuple

end  # DatesWithNanoseconds
