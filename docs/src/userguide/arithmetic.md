## Arithmetic with Periods

```
using Dates, TimeDates

julia> timedate = TimeDate("2022-04-10T02:04:08.016032064")
2022-04-10T02:04:08.016032064

julia> timedate + Month(9)
2022-12-10T02:04:08.016032064

julia> timedate - Hour(3)
2022-04-09T23:04:08.016032064

julia> timedate + Nanosecond(936)
2022-04-10T02:04:08.016033
```

### CompoundPeriods
```
julia> compound = Month(3) + Day(5) + Second(32) + Nanosecond(923)
3 months, 5 days, 32 seconds, 943 nanoseconds

julia> timedate + compound
2022-07-15T02:04:40.016032987

julia> timedate - compound
2022-01-05T02:03:36.016031141
```