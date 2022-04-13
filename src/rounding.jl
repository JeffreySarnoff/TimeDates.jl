# trunc, floor == trunc, RoundDown == trunc

Base.trunc(d::Date, ::Type{Week}) = firstdayofweek(d)
Base.trunc(d::DateTime, ::Type{Week}) = firstdayofweek(d)

Base.floor(t::Time, ::Type{Hour}) = Time(hour(t))
Base.floor(t::Time, ::Type{Minute}) = Time(hour(t), minute(t))
Base.floor(t::Time, ::Type{Second}) = Time(hour(t), minute(t), second(t))
Base.floor(t::Time, ::Type{Millisecond}) = Time(hour(t), minute(t), second(t), millisecond(t))
Base.floor(t::Time, ::Type{Microsecond}) = t - Nanosecond(t)
Base.floor(t::Time, ::Type{Nanosecond}) = t

Base.round(t::Time, ::Type{Hour}, ::RoundingMode{:Down}) = Time(hour(t))
Base.round(t::Time, ::Type{Minute}, ::RoundingMode{:Down}) = Time(hour(t), minute(t))
Base.round(t::Time, ::Type{Second}, ::RoundingMode{:Down}) = Time(hour(t), minute(t), second(t))
Base.round(t::Time, ::Type{Millisecond}, ::RoundingMode{:Down}) = Time(hour(t), minute(t), second(t), millisecond(t))
Base.round(t::Time, ::Type{Microsecond}, ::RoundingMode{:Down}) = t - Nanosecond(t)
Base.round(t::Time, ::Type{Nanosecond}, ::RoundingMode{:Down}) = t

# using a loop with @eval begin did not work well

Base.trunc(td::TimeDate, ::Type{Year}) = TimeDate(Time0, trunc(td.date, Year))
Base.trunc(td::TimeDate, ::Type{Quarter}) = TimeDate(Time0, trunc(td.date, Quarter))
Base.trunc(td::TimeDate, ::Type{Month}) = TimeDate(Time0, trunc(td.date, Month))
Base.trunc(td::TimeDate, ::Type{Week}) = TimeDate(Time0, trunc(td.date, Week))
Base.trunc(td::TimeDate, ::Type{Day}) = TimeDate(Time0, trunc(td.date, Day))
Base.trunc(td::TimeDate, ::Type{Hour}) = TimeDate(trunc(td.time, Hour), td.date)
Base.trunc(td::TimeDate, ::Type{Minute}) = TimeDate(trunc(td.time, Minute), td.date)
Base.trunc(td::TimeDate, ::Type{Second}) = TimeDate(trunc(td.time, Second), td.date)
Base.trunc(td::TimeDate, ::Type{Millisecond}) = TimeDate(trunc(td.time, Millisecond), td.date)
Base.trunc(td::TimeDate, ::Type{Microsecond}) = TimeDate(trunc(td.time, Microsecond), td.date)
Base.trunc(td::TimeDate, ::Type{Nanosecond}) = td

Base.floor(td::TimeDate, ::Type{Year}) = TimeDate(Time0, trunc(td.date, Year))
Base.floor(td::TimeDate, ::Type{Quarter}) = TimeDate(Time0, trunc(td.date, Quarter))
Base.floor(td::TimeDate, ::Type{Month}) = TimeDate(Time0, trunc(td.date, Month))
Base.floor(td::TimeDate, ::Type{Week}) = TimeDate(Time0, trunc(td.date, Week))
Base.floor(td::TimeDate, ::Type{Day}) = TimeDate(Time0, trunc(td.date, Day))
Base.floor(td::TimeDate, ::Type{Hour}) = TimeDate(trunc(td.time, Hour), td.date)
Base.floor(td::TimeDate, ::Type{Minute}) = TimeDate(trunc(td.time, Minute), td.date)
Base.floor(td::TimeDate, ::Type{Second}) = TimeDate(trunc(td.time, Second), td.date)
Base.floor(td::TimeDate, ::Type{Millisecond}) = TimeDate(trunc(td.time, Millisecond), td.date)
Base.floor(td::TimeDate, ::Type{Microsecond}) = TimeDate(trunc(td.time, Microsecond), td.date)
Base.floor(td::TimeDate, ::Type{Nanosecond}) = td

Base.round(td::TimeDate, ::Type{Year}, ::RoundingMode{:Down}) = TimeDate(Time0, trunc(td.date, Year))
Base.round(td::TimeDate, ::Type{Quarter}, ::RoundingMode{:Down}) = TimeDate(Time0, trunc(td.date, Quarter))
Base.round(td::TimeDate, ::Type{Month}, ::RoundingMode{:Down}) = TimeDate(Time0, trunc(td.date, Month))
Base.round(td::TimeDate, ::Type{Week}, ::RoundingMode{:Down}) = TimeDate(Time0, trunc(td.date, Week))
Base.round(td::TimeDate, ::Type{Day}, ::RoundingMode{:Down}) = TimeDate(Time0, trunc(td.date, Day))
Base.round(td::TimeDate, ::Type{Hour}, ::RoundingMode{:Down}) = TimeDate(trunc(td.time, Hour), td.date)
Base.round(td::TimeDate, ::Type{Minute}, ::RoundingMode{:Down}) = TimeDate(trunc(td.time, Minute), td.date)
Base.round(td::TimeDate, ::Type{Second}, ::RoundingMode{:Down}) = TimeDate(trunc(td.time, Second), td.date)
Base.round(td::TimeDate, ::Type{Millisecond}, ::RoundingMode{:Down}) = TimeDate(trunc(td.time, Millisecond), td.date)
Base.round(td::TimeDate, ::Type{Microsecond}, ::RoundingMode{:Down}) = TimeDate(trunc(td.time, Microsecond), td.date)
Base.round(td::TimeDate, ::Type{Nanosecond}, ::RoundingMode{:Down}) = td

#=
@inline Base.trunc(td::TimeDate, ::Type{P}) where {P<:DatePeriod} =
    TimeDate(Time0, trunc(td.date, P))
@inline Base.trunc(td::TimeDate, ::Type{P}) where {P<:TimePeriod} =
    TimeDate(trunc(td.time, P), td.date)

Base.floor(td::TimeDate, ::Type{P}) where {P<:DatePeriod} = trunc(td, P)
Base.floor(td::TimeDate, ::Type{P}) where {P<:TimePeriod} = trunc(td, P)

Base.round(td::TimeDate, ::Type{P}, ::RoundingMode{:Down}) where {P<:DatePeriod} = trunc(td, P)
Base.round(td::TimeDate, ::Type{P}, ::RoundingMode{:Down}) where {P<:TimePeriod} = trunc(td, P)
=#

# ceil, RoundUp == ceil

Base.ceil(td::TimeDate, ::Type{Year}) =
    TimeDate(trunc(td, Year)) + Year(((month(td) > 1) + (day(td) > 1) + hour(td) + minute(td) + second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0)
Base.ceil(td::TimeDate, ::Type{Quarter}) =
    TimeDate(trunc(td, Quarter)) + Quarter((((month(td) > 1) + (day(td) > 1) + hour(td) + minute(td) + second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::TimeDate, ::Type{Month}) =
    TimeDate(trunc(td, Month)) + Month((((day(td) > 1) + hour(td) + minute(td) + second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::TimeDate, ::Type{Week}) =
    TimeDate(trunc(td, Week)) + Week((((day(td) > 1) + hour(td) + minute(td) + second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::TimeDate, ::Type{Day}) =
    TimeDate(trunc(td, Day)) + Day(((hour(td) + minute(td) + second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::TimeDate, ::Type{Hour}) =
    TimeDate(trunc(td, Hour)) + Hour(((minute(td) + second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::TimeDate, ::Type{Minute}) =
    TimeDate(trunc(td, Minute)) + Minute(((second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::TimeDate, ::Type{Second}) =
    TimeDate(trunc(td, Second)) + Second(((millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::TimeDate, ::Type{Millisecond}) =
    TimeDate(trunc(td, Millisecond)) + Millisecond(((microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::TimeDate, ::Type{Microsecond}) =
    TimeDate(trunc(td, Microsecond)) + Microsecond(nanosecond(td) > 0)
Base.ceil(td::TimeDate, ::Type{Nanosecond}) = td

Base.ceil(td::Time, ::Type{Hour}) =
    trunc(td, Hour) + Hour(((minute(td) + second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::Time, ::Type{Minute}) =
    trunc(td, Minute) + Minute(((second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::Time, ::Type{Second}) =
    trunc(td, Second) + Second(((millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::Time, ::Type{Millisecond}) =
    trunc(td, Millisecond) + Millisecond(((microsecond(td) + nanosecond(td)) > 0))
Base.ceil(td::Time, ::Type{Microsecond}) =
    trunc(td, Microsecond) + Microsecond(nanosecond(td) > 0)
Base.ceil(td::Time, ::Type{Nanosecond}) = td

Base.round(td::Time, ::Type{Hour}, ::RoundingMode{:Up}) =
    trunc(td, Hour) + Hour(((minute(td) + second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.round(td::Time, ::Type{Minute}, ::RoundingMode{:Up}) =
    trunc(td, Minute) + Minute(((second(td) + millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.round(td::Time, ::Type{Second}, ::RoundingMode{:Up}) =
    trunc(td, Second) + Second(((millisecond(td) + microsecond(td) + nanosecond(td)) > 0))
Base.round(td::Time, ::Type{Millisecond}, ::RoundingMode{:Up}) =
    trunc(td, Millisecond) + Millisecond(((microsecond(td) + nanosecond(td)) > 0))
Base.round(td::Time, ::Type{Microsecond}, ::RoundingMode{:Up}) =
    trunc(td, Microsecond) + Microsecond(nanosecond(td) > 0)
Base.round(td::Time, ::Type{Nanosecond}, ::RoundingMode{:Up}) = td

for T in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second, :Millisecond, :Microsecond, :Nanosecond)
    @eval Base.round(td::TimeDate, ::Type{$T}, ::RoundingMode{:Up}) = ceil(td, $T)
end

# RoundNearestTiesUp, round == RoundNearestTiesUp

function Base.round(td::TimeDate, ::Type{Year}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Year)
    dys = daysinyear(td)
    dys = (dys >> 1) + isodd(dys)
    hlf = flr + Day(dys)
    delta = (Dates.value(td) - Dates.value(hlf)) >= 0
    flr + Year(delta)
end
function Base.round(td::TimeDate, ::Type{Quarter}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Quarter)
    dys = daysinquarter(td)
    dys = (dys >> 1) + isodd(dys)
    hlf = flr + Day(dys)
    delta = (Dates.value(td) - Dates.value(hlf)) >= 0
    flr + Quarter(delta)
end
function Base.round(td::TimeDate, ::Type{Month}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Month)
    dys = daysinmonth(td)
    dys = (dys >> 1) + isodd(dys)
    hlf = flr + Day(dys)
    delta = (Dates.value(td) - Dates.value(hlf)) >= 0
    flr + Month(delta)
end
function Base.round(td::TimeDate, ::Type{Week}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Week)
    dys = 7
    dys = (dys >> 1) + isodd(dys)
    hlf = flr + Day(dys)
    delta = (Dates.value(td) - Dates.value(hlf)) >= 0
    flr + Week(delta)
end
function Base.round(td::TimeDate, ::Type{Day}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Day)
    delta = (Dates.value(td) - Dates.value(flr)) >= 24 * 60 * 60 * 500_000_000
    flr + Day(delta)
end
function Base.round(td::TimeDate, ::Type{Hour}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Minute)
    delta = (Dates.value(td) - Dates.value(flr)) >= 60 * 60 * 500_000_000
    flr + Hour(delta)
end
function Base.round(td::TimeDate, ::Type{Minute}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Minute)
    delta = (Dates.value(td) - Dates.value(flr)) >= 60 * 500_000_000
    flr + Minute(delta)
end
function Base.round(td::TimeDate, ::Type{Second}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Second)
    delta = (Dates.value(td) - Dates.value(flr)) >= 500_000_000
    flr + Second(delta)
end
function Base.round(td::TimeDate, ::Type{Millisecond}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Millisecond)
    delta = (Dates.value(td) - Dates.value(flr)) >= 500_000
    flr + Millisecond(delta)
end
function Base.round(td::TimeDate, ::Type{Microsecond}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Microsecond)
    delta = (Dates.value(td) - Dates.value(flr)) >= 500
    flr + Microsecond(delta)
end
Base.round(td::TimeDate, ::Type{Nanosecond}, ::RoundingMode{:NearestTiesUp}) = td

function Base.round(td::Time, ::Type{Hour}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Minute)
    delta = (Dates.value(td) - Dates.value(flr)) >= 60 * 60 * 500_000_000
    flr + Hour(delta)
end
function Base.round(td::Time, ::Type{Minute}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Minute)
    delta = (Dates.value(td) - Dates.value(flr)) >= 60 * 500_000_000
    flr + Minute(delta)
end
function Base.round(td::Time, ::Type{Second}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Second)
    delta = (Dates.value(td) - Dates.value(flr)) >= 500_000_000
    flr + Second(delta)
end
function Base.round(td::Time, ::Type{Millisecond}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Millisecond)
    delta = (Dates.value(td) - Dates.value(flr)) >= 500_000
    flr + Millisecond(delta)
end
function Base.round(td::Time, ::Type{Microsecond}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Microsecond)
    delta = (Dates.value(td) - Dates.value(flr)) >= 500
    flr + Microsecond(delta)
end
Base.round(td::Time, ::Type{Nanosecond}, ::RoundingMode{:NearestTiesUp}) = td

for T in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second, :Millisecond, :Microsecond, :Nanosecond)
    @eval Base.round(td::TimeDate, ::Type{$T}) = round(td, $T, RoundNearestTiesUp)
end
