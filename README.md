# TimeDates.jl

### TimeDate is nanosecond resolved DateTime-like type.

[![docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://jeffreysarnoff.github.io/TimeDates.jl/dev/)
[![coverage](https://codecov.io/gh/JeffreySarnoff/TimeDates.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/JeffreySarnoff/TimeDates.jl)

----

* A date-and-time type with nanosecond resolution
* TimeDate works like DateTime with more precision
* Supports Dates.jl methods
* Adds ranges with CompoundPeriod steps
* Adds `periods`, a NamedTuple constructor

## Quick Start

### construction
```
using Dates, TimeDates

julia> date = Date(2022, 04, 10)
2022-04-10

time = Time(2, 4, 8, 16, 32, 64)
02:04:08.016032064

julia> timedate = TimeDate(2022, 04, 10, 2, 4, 8, 16, 32, 64)
2022-04-10T02:04:08.016032064

julia> timedate == TimeDate(date, time) == TimeDate(time, date)
true
```

### use

- Use TimeDates as you would use DateTimes.
- Interconvert with DateTime, Date, Time

#### current limitations

- please submit an issue

----

This is a rewrite of [TimesDates](https://github.com/JeffreySarnoff/TimesDates.jl) without the time zone support.

