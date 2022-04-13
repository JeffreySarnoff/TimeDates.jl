## Arithmetic with Periods

```
using Dates, TimeDates

julia> timedate = TimeDate("2022-04-10T02:04:08.016032064");
2022-04-10T02:04:08.016032064

julia> timedate + Month(8), timedate + Month(9)
(2022-12-10T02:04:08.016032064, 2023-01-10T02:04:08.016032064)

#= !!FIXME

julia> timedate - Hour(3)
2022-04-10T23:04:08.016032064

julia> timedate
2022-04-10T02:04:08.016032064

julia> timedate - Hour(3+24)
2022-04-09T23:04:08.016032064
=#

julia> timedate + Hour(24)
2022-05-10T02:04:08.016032064

julia> timedate - Hour(8)
2022-05-10T02:04:08.016032064
```
