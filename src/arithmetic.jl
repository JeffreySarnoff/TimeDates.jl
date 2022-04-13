for T in (:Hour, :Minute, :Second, :Millisecond, :Microsecond, :Nanosecond)
    @eval begin
        function Base.:(+)(td::TimeDate, x::$T)
            totalnanos = Dates.value(td) + Dates.value(x)
            ndays, nnanos = divrem(totalnanos, NanosecondsPerDay)
            TimeDate(rata2datetime(ndays)) + Nanosecond(nnanos)
        end

        Base.:(+)(x::$T, td::TimeDate) = td + x
        
        function Base.:(-)(td::TimeDate, x::$T)
            totalnanos = Dates.value(td) - Dates.value(x)
            ndays, nnanos = divrem(totalnanos, NanosecondsPerDay)
            TimeDate(rata2datetime(ndays)) + Nanosecond(nnanos)
        end
    end
end

for F in (:Week, :Day)
    @eval begin
        function Base.:(+)(td::TimeDate, x::$T)
            totalnanos = Dates.value(td) + Dates.tons(x)
            ndays, nnanos = divrem(totalnanos, NanosecondsPerDay)
            TimeDate(rata2datetime(ndays)) + Nanosecond(nnanos)
        end

        Base.:(+)(x::$T, td::TimeDate) = td + x

        function Base.:(-)(td::TimeDate, x::$T)
            totalnanos = Dates.value(td) - Dates.tons(x)
            ndays, nnanos = divrem(totalnanos, NanosecondsPerDay)
            TimeDate(rata2datetime(ndays)) + Nanosecond(nnanos)
        end

    end
end

for F in (:Year, :Quarter, Month)
    @eval begin
        function Base.:(+)(td::TimeDate, x::$T)
            TimeDate(td.time, td.date + x)
        end

        Base.:(+)(x::$T, td::TimeDate) = td + x

        function Base.:(-)(td::TimeDate, x::$T)
            TimeDate(td.time, td.date - x)
        end

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
