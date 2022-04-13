## Constructing TimeDate values

```
using Dates, TimeDates


julia> timedate = TimeDate("2022-04-10T02:04:08.016032064")
2022-04-10T02:04:08.016032064

# you may use meaningful leading substrings
julia> TimeDate("2022"), TimeDate("2022-04-10")
(2022-01-01, 2022-04-10)

julia> timedate = TimeDate(2022, 04, 10, 2, 4, 8, 16, 32, 64)
2022-04-10T02:04:08.016032064

# you may specify 1,2..9 positional values
julia> TimeDate(2022), TimeDate(2022, 4, 10)
(2022-01-01, 2022-04-10)

julia> date = Date(2022, 04, 10)
2022-04-10

time = Time(2, 4, 8, 16, 32, 64)
02:04:08.016032064

julia> TimeDate(time, date) == TimeDate(date, time)
true
```
