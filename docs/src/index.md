# DatesWithNanoseconds.jl
### TimeDate is a nanosecond resolved type similar to DateTime.

* A date-and-time type with nanosecond resolution
* TimeDate works like DateTime with more precision
* Supports many Dates.jl methods
* Adds ranges with CompoundPeriod steps
* Adds `periods`, a NamedTuple constructor

## Quick Start

### construction
```
using DatesWithNanoseconds

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

#### limitations

`dateformat` is not supported
- The standard format is "2022-04-10T02:04:08.016032064"
  - `string(::TimeDate)` works with the standard format
  - `TimeDate(::string)` works with the standard format

