struct TimeDate <: Dates.AbstractDateTime
    time::Time
    date::Date
end

TimeDate(x::TimeDate) = x
TimeDate(date::Date, time::Time) = TimeDate(time, date)
TimeDate(; time::Time=Time0, date::Date=today()) = TimeDate(time, date)

function TimeDate(time::Time, date::Date, us::Microsecond, ns::Nanosecond=Nanosecond(0))
    usns = us + ns
    time += usns
    TimeDate(time, date)
end

TimeDate(date::Date, time::Time, us::Microsecond, ns::Nanosecond=Nanosecond(0)) =
    TimeDate(time, date, us, ns)

TimeDate(time::Time, date::Date, us::T, ns::T=0) where {T<:Integer} =
    TimeDate(time, date, Microsecond(us), Nanosecond(ns))

TimeDate(date::Date, time::Time, us::T, ns::T=0) where {T<:Integer} =
    TimeDate(time, date, Microsecond(us), Nanosecond(ns))

# DateTime
TimeDate(x::DateTime) = TimeDate(Time(x), Date(x))

TimeDate(x::DateTime, us::Microsecond, ns::Nanosecond=Nanosecond(0)) =
    TimeDate(Time(x) + us + ns, Date(x))

TimeDate(x::DateTime, us::T, ns::T=0) where {T<:Integer} =
    TimeDate(x, Microsecond(us), Nanosecond(ns))

# Date, Time
TimeDate(x::Date) = TimeDate(Time0, x)
TimeDate(x::Time) = TimeDate(x, today())

# Periods
TimeDate(y::T, m::T=1, d::T=1, H::T=0, M::T=0, S::T=0, ms::T=0, us::T=0, ns::T=0) where {T<:Integer} =
    TimeDate(Time(H, M, S, ms, us, ns), Date(y, m, d))

TimeDate(y::Year, m::Month=Month(1), d::Day=Day(1),
    H::Hour=Hour(0), M::Minute=Minute(0), S::Second=Second(0),
    ms::Millisecond=Millisecond(0), us::Microsecond=Microsecond(0), ns::Nanosecond=Nanosecond(0)) =
    TimeDate(Time(H, M, S, ms, us, ns), Date(y, m, d))

# construct(::TimeDate)

Dates.Time(x::TimeDate) = x.time
Dates.Date(x::TimeDate) = x.date
Dates.DateTime(x::TimeDate) = DateTime(x.date, x.time - Microsecond(x.time) - Nanosecond(x.time))

Base.convert(::Type{TimeDate}, x::DateTime) = TimeDate(x)
Base.convert(::Type{TimeDate}, x::Date) = TimeDate(x)
Base.promote_rule(::Type{TimeDate}, ::Type{DateTime}) = TimeDate
Base.promote_rule(::Type{TimeDate}, ::Type{Date}) = TimeDate
