for (T, PerDay) in ((:Hour, HoursPerDay), (:Minute, MinutesPerDay), (:Second, SecondsPerDay), (:Millisecond, MillisecondsPerDay), (:Microsecond, MicrosecondsPerDay), (:Nanosecond, NanosecondsPerDay))
    @eval begin
        function Base.:(+)(td::TimeDate, x::$T)
            yearnum = year(td)
            date = Date(yearnum)
            ndays = Dates.days(td) - Dates.days(date) + Dates.days(x)
            nnanos = value(td.time) + Dates.tons(x)
            time = Time(Nanosecond(nnanos))
            date = date + Day(ndays)
            TimeDate(time, date)
        end
        Base.:(+)(x::$T, td::TimeDate) = td + x
        function Base.:(-)(td::TimeDate, x::$T)
            yearnum = year(td)
            date = Date(yearnum)
            ndays = Dates.days(td) - Dates.days(date) - Dates.days(x)
            nnanos = value(td.time) - Dates.tons(x)
            time = Time(Nanosecond(nnanos))
            date = date + Day(ndays)
            TimeDate(time, date)
        end
    end
end

for F in (:Year, :Quarter, :Month, :Week, :Day)
    @eval begin
        Base.:(+)(td::TimeDate, x::$F) = TimeDate(td.time, td.date + x)
        Base.:(+)(x::$F, td::TimeDate) = td + x
        Base.:(-)(td::TimeDate, x::$F) = TimeDate(td.time, td.date - x)
    end
end

# TimeDate subtraction that does not overflow Nanoseconds

function Base.:(-)(td1::TimeDate, td2::TimeDate)
    ddate = td1.date - td2.date
    dtime = td1.time - td2.time
    if dtime < Nanosecond(0) && ddate >= Day(1)
        ddate = ddate - Day(1)
        dtime = dtime + Nanosecond(NanosecondsPerDay)
    end
    ddate + canonicalize(dtime)
end

Base.:(-)(td::TimeDate, dt::DateTime) = (-)(td, TimeDate(dt))
Base.:(-)(td::TimeDate, d::Date) = (-)(td, TimeDate(d))
Base.:(-)(d::Date, td::TimeDate) = (-)(TimeDate(d), td)
