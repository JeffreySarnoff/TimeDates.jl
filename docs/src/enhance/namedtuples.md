## NamedTuples

The function `periods` converts a `TimeDate`, `Time`, `Date`, or `DateTime`
into a `NamedTuple` where the names are the lowercase periods.

```
using Dates, TimeDates

julia> date = Date(2022, 04, 10)
2022-04-10

julia> date_periods = periods(date)
(year = 2022, month = 4, day = 10)

julia> time = Time(2, 4, 8, 16, 32, 64)
02:04:08.016032064

julia> time_periods = periods(time)
(hour = 2, minute = 4, second = 8, millisecond = 16,
 microsecond = 32, nanosecond = 64)

julia> datetime = DateTime(date, trunc(time, Millisecond))
2022-04-10T02:04:08.16

julia> datetime_periods = periods(datetime)
(year = 2022, month = 4, day = 10,
 hour = 2, minute = 4, second = 8, millisecond = 16)

julia> timedate = TimeDate(time, date)
2022-04-10T02:04:08.016032064

julia> timedate_periods = periods(timedate)
(year = 2022, month = 4, day = 10,
 hour = 2, minute = 4, second = 8, millisecond = 16,
 microsecond = 32, nanosecond = 64)
```

There are four ways to access each value.

```
# the NamedTuple field access methods

julia> date_periods.month, date_periods[2]
(4, 4)

julia> timedate_periods.second, timedate_periods[6]
(8, 8)

# the period accessor functions from `Dates`

julia> month(date_periods), Month(date_periods)
(4, 4 months)

julia> second(timedate_periods), Second(timedate_periods)
(8, 8 seconds)
```
