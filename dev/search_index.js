var documenterSearchIndex = {"docs":
[{"location":"enhance/namedtuples/#NamedTuples","page":"Using NamedTuples","title":"NamedTuples","text":"","category":"section"},{"location":"enhance/namedtuples/","page":"Using NamedTuples","title":"Using NamedTuples","text":"The function periods converts a TimeDate, Time, Date, or DateTime into a NamedTuple where the names are the lowercase periods.","category":"page"},{"location":"enhance/namedtuples/","page":"Using NamedTuples","title":"Using NamedTuples","text":"using DatesWithNanoseconds\n\njulia> date = Date(2022, 04, 10)\n2022-04-10\n\njulia> date_periods = periods(date)\n(year = 2022, month = 4, day = 10)\n\njulia> time = Time(2, 4, 8, 16, 32, 64)\n02:04:08.016032064\n\njulia> time_periods = periods(time)\n(hour = 2, minute = 4, second = 8, millisecond = 16,\n microsecond = 32, nanosecond = 64)\n\njulia> datetime = DateTime(date, trunc(time, Millisecond))\n2022-04-10T02:04:08.16\n\njulia> datetime_periods = periods(datetime)\n(year = 2022, month = 4, day = 10,\n hour = 2, minute = 4, second = 8, millisecond = 16)\n\njulia> timedate = TimeDate(time, date)\n2022-04-10T02:04:08.016032064\n\njulia> timedate_periods = periods(timedate)\n(year = 2022, month = 4, day = 10,\n hour = 2, minute = 4, second = 8, millisecond = 16,\n microsecond = 32, nanosecond = 64)","category":"page"},{"location":"enhance/namedtuples/","page":"Using NamedTuples","title":"Using NamedTuples","text":"There are four ways to access each value.","category":"page"},{"location":"enhance/namedtuples/","page":"Using NamedTuples","title":"Using NamedTuples","text":"# the NamedTuple field access methods\n\njulia> date_periods.month, date_periods[2]\n(4, 4)\n\njulia> timedate_periods.second, timedate_periods[6]\n(8, 8)\n\n# the period accessor functions from `Dates`\n\njulia> month(date_periods), Month(date_periods)\n(4, 4 months)\n\njulia> second(timedate_periods), Second(timedate_periods)\n(8, 8 seconds)","category":"page"},{"location":"enhance/ranges/#Ranges-with-CompoundPeriods","page":"Compound Ranges","title":"Ranges with CompoundPeriods","text":"","category":"section"},{"location":"enhance/ranges/","page":"Compound Ranges","title":"Compound Ranges","text":"julia> start = TimeDate(2000);\r\njulia> stop  = TimeDate(2000) + Microsecond(1)\r\njulia> step  = Nanosecond(500);\r\n\r\njulia> collect(start:step:stop)\r\n3-element Vector{TimeDate}:\r\n 2000-01-01T00:00:00\r\n 2000-01-01T00:00:00.0000005\r\n 2000-01-01T00:00:00.000001\r\n \r\njulia> stop = TimeDate(2000) + Month(3);\r\njulia> step = Day(40) + Hour(12);\r\n\r\njulia> collect(start:step:stop)\r\n3-element Vector{TimeDate}:\r\n 2000-01-01T00:00:00\r\n 2000-02-10T12:00:00\r\n 2000-03-22T00:00:00","category":"page"},{"location":"enhance/ranges/","page":"Compound Ranges","title":"Compound Ranges","text":"Ranged CompoundPeriods must not include Year or Month.","category":"page"},{"location":"#DatesWithNanoseconds.jl","page":"Home","title":"DatesWithNanoseconds.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Offers TimeDate, a nanosecond resolved type similar to DateTime.","category":"page"},{"location":"","page":"Home","title":"Home","text":"A date-and-time type with nanosecond resolution\nTimeDate works like DateTime with more precision\nSupports many Dates.jl methods\nAdds ranges with CompoundPeriod steps\nAdds periods, a NamedTuple constructor","category":"page"},{"location":"#Quick-Start","page":"Home","title":"Quick Start","text":"","category":"section"},{"location":"#construction","page":"Home","title":"construction","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using DatesWithNanoseconds\n\njulia> date = Date(2022, 04, 10)\n2022-04-10\n\ntime = Time(2, 4, 8, 16, 32, 64)\n02:04:08.016032064\n\njulia> timedate = TimeDate(2022, 04, 10, 2, 4, 8, 16, 32, 64)\n2022-04-10T02:04:08.016032064\n\njulia> timedate == TimeDate(date, time) == TimeDate(time, date)\ntrue","category":"page"},{"location":"#use","page":"Home","title":"use","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Use TimeDates as you would use DateTimes.","category":"page"},{"location":"#current-limitations","page":"Home","title":"current limitations","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"dateformat is not supported\nuse string(::TimeDate) and TimeDate(string(::TimeDate))\nThe standard format is \"2022-04-10T02:04:08.016032064\"","category":"page"}]
}
