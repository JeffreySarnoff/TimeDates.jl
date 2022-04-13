## Accessing Constituents

* the accessors work just as they do with Dates, Times

```
julia> using Dates, TimeDates

julia> timedate = TimeDate("2022-04-10T02:04:08.016032064")
2022-04-10T02:04:08.016032064

julia> Year(timedate), Hour(timedate), Microsecond(timedate)
Year(2022), Hour(2), Microsecond(32)

julia> month(timedate), second(timedate), nanosecond(timedate)
4, 8, 64
```
