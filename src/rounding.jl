const HalfPriorPeriod = (
    Hour=Nanosecond(Minute(30)), Minute=Nanosecond(Second(30)),
    Second=Nanosecond(Millisecond(500)), Millisecond=Nanosecond(Microsecond(500)),
    Microsecond=Nanosecond(500), Nanosecond=Nanosecond(0))

# general case rounding to the DatePeriod

for period in (:Year, :Quarter, :Month, :Week)
    @eval begin
        Base.trunc(td::TimeDate, p::Type{$period}) = TimeDate(Time0, trunc(td.date, p))

        Base.round(td::TimeDate, p::Type{$period}, ::RoundingMode{:NearestTiesUp}) = TimeDate(Time0, round(td.date, $period, RoundNearestTiesUp))
        Base.round(td::TimeDate, p::Type{$period}, ::RoundingMode{:Up}) = TimeDate(Time0, round(td.date, $period, RoundUp))
        Base.round(td::TimeDate, p::Type{$period}, ::RoundingMode{:Down}) = TimeDate(Time0, round(td.date, $period, RoundDown))
        Base.round(td::TimeDate, p::Type{$period}) = round(td, p, RoundNearestTiesUp)
    end
end

# special case rounding to the Day

Base.trunc(td::TimeDate, p::Type{Day}) = TimeDate(Time0, trunc(td.date, Day))
Base.round(td::TimeDate, p::Type{Day}, ::RoundingMode{:Down}) = trunc(td, Day)
Base.round(td::TimeDate, p::Type{Day}) = round(td, Day, RoundNearestTiesUp)

function Base.round(td::TimeDate, p::Type{Day}, ::RoundingMode{:NearestTiesUp})
    diff = value(td.time)
    rollover = diff >= Nanosecond(Hour(12))
    TimeDate(Time0, td.date + Day(rollover))
end
function Base.round(td::TimeDate, p::Type{Day}, ::RoundingMode{:Up})
    date = td.date + Day(!iszero(td.time))
    TimeDate(Time0, date)
end

# general case rounding to the TimePeriod

for period in (:Minute, :Second, :Millisecond, :Microsecond, :Nanosecond)
    @eval begin
        Base.trunc(td::TimeDate, p::Type{$period}) = TimeDate(trunc(td.time, p), td.date)

        function Base.round(td::TimeDate, p::Type{$period}, ::RoundingMode{:Up})
            t = trunc(td.time, $period)
            diff = value(td.time - t)
            t = t + $period(diff != 0)
            TimeDate(t, td.date)
        end

        function Base.round(td::TimeDate, p::Type{$period}, ::RoundingMode{:Down})
            t = trunc(td.time, $period)
            TimeDate(t, td.date)
        end

        function Base.round(td::TimeDate, p::Type{$period}, ::RoundingMode{:NearestTiesUp})
            t = trunc(td.time, $period)
            diff = td.time - t
            rollover = diff >= HalfPriorPeriod[Symbol($period)]
            TimeDate(t + $period(rollover), td.date)
        end

        Base.round(td::TimeDate, p::Type{$period}) = round(td, p, RoundNearestTiesUp)
    end
end

# special case rounding to the Hour

Base.trunc(td::TimeDate, p::Type{Hour}) = TimeDate(trunc(td.time, Hour), td.date)
Base.round(td::TimeDate, p::Type{Hour}, ::RoundingMode{:Down}) = trunc(td, Hour)
Base.round(td::TimeDate, p::Type{Hour}) = round(td, Hour, RoundNearestTiesUp)

function Base.round(td::TimeDate, p::Type{Hour}, ::RoundingMode{:NearestTiesUp})
    t = trunc(td.time, Hour)
    diff = td.time - t
    rollover = diff >= Nanosecond(30 * PerNanosecondsPerMinute)
    rolloverdate = hour(t) === 23 && rollover
    TimeDate(t + Hour(rollover), td.date + Day(rolloverdate))
end
function Base.round(td::TimeDate, p::Type{Hour}, ::RoundingMode{:Up})
    t = trunc(td.time, Hour)
    diff = td.time - t
    rollover = diff > Nanosecond(0)
    rolloverdate = hour(t) === 23 && rollover
    TimeDate(t + Hour(rollover), td.date + Day(rolloverdate))
end
