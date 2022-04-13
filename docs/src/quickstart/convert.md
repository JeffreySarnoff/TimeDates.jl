## Conversion

```
using Dates, TimeDates

julia> TimeDate(2022, 4, 10, 2, 4, 8, 16, 32, 64)
2022-04-10T02:04:08.016032064

julia> date = Date(2022, 04, 10)
2022-04-10

julia> TimeDate(date)
2022-04-10

julia> time = Time(2, 4, 8, 16, 32, 64)
02:04:08.016032064

julia> TimeDate(time, date), TimeDate(date, time)
2022-04-10T02:04:08.016032064
2022-04-10T02:04:08.016032064

julia> datetime = DateTime(date, time)
2022-04-10T02:04:08.016

julia> TimeDate(datetime)
2022-04-10T02:04:08.016

julia> TimeDate(datetime, 32, 64),
       TimeDate(datetime, Microsecond(32), Nanosecond(64))
(2022-04-10T02:04:08.016032064,
 2022-04-10T02:04:08.016032064)

julia> TimeDate(datetime, Microsecond(456)),
       TimeDate(datetime, Nanosecond(456))
(2022-04-10T02:04:08.016456,
 2022-04-10T02:04:08.016000456)
```