## Ranges with CompoundPeriods 

```
julia> using Dates, TimeDates

julia> start = TimeDate(2000);
julia> stop  = TimeDate(2000) + Microsecond(1)
julia> step  = Nanosecond(500);

julia> collect(start:step:stop)
3-element Vector{TimeDate}:
 2000-01-01T00:00:00
 2000-01-01T00:00:00.0000005
 2000-01-01T00:00:00.000001
 
julia> stop = TimeDate(2000) + Month(3);
julia> step = Day(40) + Hour(12);

julia> collect(start:step:stop)
3-element Vector{TimeDate}:
 2000-01-01T00:00:00
 2000-02-10T12:00:00
 2000-03-22T00:00:00
```

*Ranged CompoundPeriods must not include `Year` or `Month`*.
