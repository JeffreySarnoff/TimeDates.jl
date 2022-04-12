yr, mo, dy, hr, mn, sc, ms, us, ns = (2022, 04, 09, 12, 48, 35, 877, 012, 505)

ayear, amonth, aday,
ahour, aminute, asecond,
amillisecond, amicrosecond, ananosecond =
    Year(yr), Month(mo), Day(dy),
    Hour(hr), Minute(mn), Second(sc),
    Millisecond(ms), Microsecond(us), Nanosecond(ns)

atimedate = TimeDate(yr, mo, dy, hr, mn, sc, ms, us, ns)
adatetime = DateTime(yr, mo, dy, hr, mn, sc, ms)
adate = Date(yr, mo, dy)
atime = Time(hr, mn, sc, ms, us, ns)
atime_hms = Time(hr, mn, sc, 0, 0, 0)
atime_hmsm = Time(hr, mn, sc, ms, 0, 0)
atimedate_str = "2022-04-09T12:48:35.877012505"

earlier_timedate = TimeDate(yr, mo, dy - 1, hr, mn - 1, sc, ms, us, ns - 1)
earlier_datetime = DateTime(yr, mo, dy - 1, hr, mn - 1, sc, ms - 1)
earlier_date = Date(yr, mo, dy - 1)
earlier_time = Time(hr, mn - 1, sc, ms, us, ns - 1)

later_timedate = TimeDate(yr, mo, dy + 1, hr, mn + 1, sc, ms, us, ns + 1)
later_datetime = DateTime(yr, mo, dy + 1, hr, mn + 1, sc, ms + 1)
later_date = Date(yr, mo, dy + 1)
later_time = Time(hr, mn + 1, sc, ms, us, ns + 1)

td1str = "2011-05-08T11:15:00"
td2str = "2015-08-17T21:08:11.125"
td3str = "2018-03-09T18:29:00.042968075"
td4str = "2018-03-09T18:29:00.42096875"
td5str = "2018-03-09T18:29:00.042968750"

td1 = TimeDate(2011, 05, 08, 11, 15, 00)
td2 = TimeDate(2015, 08, 17, 21, 08, 11, 125)
td3 = TimeDate(2018, 03, 09, 18, 29, 00, 042, 968, 075)
td4 = TimeDate(2018, 03, 09, 18, 29, 00, 420, 968, 750)
td5 = TimeDate(2018, 03, 09, 18, 29, 00, 042, 968, 750)

dt1 = DateTime(2011, 05, 08, 11, 15, 00)
dt2 = DateTime(2015, 08, 17, 21, 08, 11, 125)
dt3 = DateTime(2018, 03, 09, 18, 29, 00, 042)
dt4 = DateTime(2018, 03, 09, 18, 29, 00, 420)

dates = (
    jan1_1999=Date(1999, 1, 1),
    dec31_1999=Date(1999, 12, 31),
    feb1_2000=Date(2000, 2, 1),
    mar1_2000=Date(2000, 3, 1),
)

times = (
    zero=Time(0, 0, 0, 0, 0, 0),
    sec1=Time(0, 0, 1, 0, 0, 0),
    hr1=Time(1, 0, 0, 0, 0, 0),
    max=Time(23, 59, 59, 999, 999, 999),
    max1129=Time(11, 29, 59, 999, 999, 999),
    exact1130=Time(11, 30, 0, 0, 0, 0),
    max11=Time(11, 59, 59, 999, 999, 999),
    exact12=Time(12, 0, 0, 0, 0, 0),
)

namesyms = []
time_dates = []
date_times = []

for d in keys(dates)
    for t in keys(times)
        push!(namesyms, Symbol(Symbol(d), :(_), Symbol(t)))
    end
end

for d in values(dates)
    for t in values(times)
        push!(time_dates, TimeDate(t, d))
        tm = t - Microsecond(t) - Nanosecond(t)
        push!(date_times, DateTime(d, tm))
    end
end

timedates = NamedTuple(map(Pair, namesyms, time_dates))
datetimes = NamedTuple(map(Pair, namesyms, date_times))
