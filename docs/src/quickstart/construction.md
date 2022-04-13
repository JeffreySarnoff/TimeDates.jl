## Constructing TimeDate values

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
