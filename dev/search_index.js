var documenterSearchIndex = {"docs":
[{"location":"quickstart/convert/#Conversion","page":"Conversion","title":"Conversion","text":"","category":"section"},{"location":"quickstart/convert/","page":"Conversion","title":"Conversion","text":"using Dates, TimeDates\n\njulia> TimeDate(2022, 4, 10, 2, 4, 8, 16, 32, 64)\n2022-04-10T02:04:08.016032064\n\njulia> date = Date(2022, 04, 10)\n2022-04-10\n\njulia> TimeDate(date)\n2022-04-10\n\njulia> time = Time(2, 4, 8, 16, 32, 64)\n02:04:08.016032064\n\njulia> TimeDate(time, date), TimeDate(date, time)\n2022-04-10T02:04:08.016032064\n2022-04-10T02:04:08.016032064\n\njulia> datetime = DateTime(date, time)\n2022-04-10T02:04:08.016\n\njulia> TimeDate(datetime)\n2022-04-10T02:04:08.016\n\njulia> TimeDate(datetime, 32, 64),\n       TimeDate(datetime, Microsecond(32), Nanosecond(64))\n(2022-04-10T02:04:08.016032064,\n 2022-04-10T02:04:08.016032064)\n\njulia> TimeDate(datetime, Microsecond(456)),\n       TimeDate(datetime, Nanosecond(456))\n(2022-04-10T02:04:08.016456,\n 2022-04-10T02:04:08.016000456)","category":"page"},{"location":"enhance/namedtuples/#NamedTuples","page":"Using NamedTuples","title":"NamedTuples","text":"","category":"section"},{"location":"enhance/namedtuples/","page":"Using NamedTuples","title":"Using NamedTuples","text":"The function periods converts a TimeDate, Time, Date, or DateTime into a NamedTuple where the names are the lowercase periods.","category":"page"},{"location":"enhance/namedtuples/","page":"Using NamedTuples","title":"Using NamedTuples","text":"using Dates, TimeDates\n\njulia> date = Date(2022, 04, 10)\n2022-04-10\n\njulia> date_periods = periods(date)\n(year = 2022, month = 4, day = 10)\n\njulia> time = Time(2, 4, 8, 16, 32, 64)\n02:04:08.016032064\n\njulia> time_periods = periods(time)\n(hour = 2, minute = 4, second = 8, millisecond = 16,\n microsecond = 32, nanosecond = 64)\n\njulia> datetime = DateTime(date, trunc(time, Millisecond))\n2022-04-10T02:04:08.16\n\njulia> datetime_periods = periods(datetime)\n(year = 2022, month = 4, day = 10,\n hour = 2, minute = 4, second = 8, millisecond = 16)\n\njulia> timedate = TimeDate(time, date)\n2022-04-10T02:04:08.016032064\n\njulia> timedate_periods = periods(timedate)\n(year = 2022, month = 4, day = 10,\n hour = 2, minute = 4, second = 8, millisecond = 16,\n microsecond = 32, nanosecond = 64)","category":"page"},{"location":"enhance/namedtuples/","page":"Using NamedTuples","title":"Using NamedTuples","text":"There are four ways to access each value.","category":"page"},{"location":"enhance/namedtuples/","page":"Using NamedTuples","title":"Using NamedTuples","text":"# the NamedTuple field access methods\n\njulia> date_periods.month, date_periods[2]\n(4, 4)\n\njulia> timedate_periods.second, timedate_periods[6]\n(8, 8)\n\n# the period accessor functions from `Dates`\n\njulia> month(date_periods), Month(date_periods)\n(4, 4 months)\n\njulia> second(timedate_periods), Second(timedate_periods)\n(8, 8 seconds)","category":"page"},{"location":"quickstart/accessor/#Accessing-Constituents","page":"Accessing","title":"Accessing Constituents","text":"","category":"section"},{"location":"quickstart/accessor/","page":"Accessing","title":"Accessing","text":"the accessors work just as they do with Dates, Times","category":"page"},{"location":"quickstart/accessor/","page":"Accessing","title":"Accessing","text":"julia> using Dates, TimeDates\n\njulia> timedate = TimeDate(\"2022-04-10T02:04:08.016032064\")\n2022-04-10T02:04:08.016032064\n\njulia> Year(timedate), Hour(timedate), Microsecond(timedate)\nYear(2022), Hour(2), Microsecond(32)\n\njulia> month(timedate), second(timedate), nanosecond(timedate)\n4, 8, 64","category":"page"},{"location":"userguide/arithmetic/#Arithmetic-with-Periods","page":"Arithmetic","title":"Arithmetic with Periods","text":"","category":"section"},{"location":"userguide/arithmetic/","page":"Arithmetic","title":"Arithmetic","text":"using Dates, TimeDates\n\njulia> timedate = TimeDate(\"2022-04-10T02:04:08.016032064\")\n2022-04-10T02:04:08.016032064\n\njulia> timedate + Month(9)\n2022-12-10T02:04:08.016032064\n\njulia> timedate - Hour(3)\n2022-04-09T23:04:08.016032064\n\njulia> timedate + Nanosecond(936)\n2022-04-10T02:04:08.016033","category":"page"},{"location":"userguide/arithmetic/#CompoundPeriods","page":"Arithmetic","title":"CompoundPeriods","text":"","category":"section"},{"location":"userguide/arithmetic/","page":"Arithmetic","title":"Arithmetic","text":"julia> compound = Month(3) + Day(5) + Second(32) + Nanosecond(923)\n3 months, 5 days, 32 seconds, 943 nanoseconds\n\njulia> timedate + compound\n2022-07-15T02:04:40.016032987\n\njulia> timedate - compound\n2022-01-05T02:03:36.016031141","category":"page"},{"location":"enhance/ranges/#Ranges-with-CompoundPeriods","page":"Compound Ranges","title":"Ranges with CompoundPeriods","text":"","category":"section"},{"location":"enhance/ranges/","page":"Compound Ranges","title":"Compound Ranges","text":"julia> using Dates, TimeDates\r\n\r\njulia> start = TimeDate(2000);\r\njulia> stop  = TimeDate(2000) + Microsecond(1)\r\njulia> step  = Nanosecond(500);\r\n\r\njulia> collect(start:step:stop)\r\n3-element Vector{TimeDate}:\r\n 2000-01-01T00:00:00\r\n 2000-01-01T00:00:00.0000005\r\n 2000-01-01T00:00:00.000001\r\n \r\njulia> stop = TimeDate(2000) + Month(3);\r\njulia> step = Day(40) + Hour(12);\r\n\r\njulia> collect(start:step:stop)\r\n3-element Vector{TimeDate}:\r\n 2000-01-01T00:00:00\r\n 2000-02-10T12:00:00\r\n 2000-03-22T00:00:00","category":"page"},{"location":"enhance/ranges/","page":"Compound Ranges","title":"Compound Ranges","text":"Ranged CompoundPeriods must not include Year or Month.","category":"page"},{"location":"#TimeDates.jl","page":"Home","title":"TimeDates.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Offers TimeDate, a date-and-time type with nanosecond resolution","category":"page"},{"location":"","page":"Home","title":"Home","text":"TimeDate works like DateTime with more precision\nSupports Dates.jl methods\nInterconverts with DateTime, Date\nAdds ranges with CompoundPeriod steps\nAdds periods, a NamedTuple constructor\nintroduces round(::Time, ::TimePeriod, ::RoundingMode)","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"installs with  using Pkg; Pkg.add(\"TimeDates\")\nask questions\non Discourse\non Slack\non Zulip – using the stream dates-times-zones\nreport any issues here","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"click on the triple bar at the upper right for the docs menu","category":"page"},{"location":"userguide/rounding/#Robust-Rounding","page":"Rounding","title":"Robust Rounding","text":"","category":"section"},{"location":"quickstart/construction/#Constructing-TimeDate-values","page":"Construction","title":"Constructing TimeDate values","text":"","category":"section"},{"location":"quickstart/construction/","page":"Construction","title":"Construction","text":"using Dates, TimeDates\n\n\njulia> timedate = TimeDate(\"2022-04-10T02:04:08.016032064\")\n2022-04-10T02:04:08.016032064\n\n# you may use meaningful leading substrings\njulia> TimeDate(\"2022\"), TimeDate(\"2022-04-10\")\n(2022-01-01, 2022-04-10)\n\njulia> timedate = TimeDate(2022, 04, 10, 2, 4, 8, 16, 32, 64)\n2022-04-10T02:04:08.016032064\n\n# you may specify 1,2..9 positional values\njulia> TimeDate(2022), TimeDate(2022, 4, 10)\n(2022-01-01, 2022-04-10)\n\njulia> date = Date(2022, 04, 10)\n2022-04-10\n\ntime = Time(2, 4, 8, 16, 32, 64)\n02:04:08.016032064\n\njulia> TimeDate(time, date) == TimeDate(date, time)\ntrue","category":"page"}]
}
