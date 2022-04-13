# trunc, floor == trunc, RoundDown == trunc

@inline Base.trunc(td::TimeDate, ::Type{P}) where {P<:DatePeriod} =
    TimeDate(Time0, trunc(td.date, P))
@inline Base.trunc(td::TimeDate, ::Type{P}) where {P<:TimePeriod} =
    TimeDate(trunc(td.time, P), td.date)

Base.floor(td::TimeDate, ::Type{P}) where {P<:DatePeriod} = trunc(td, P)
Base.floor(td::TimeDate, ::Type{P}) where {P<:TimePeriod} = trunc(td, P)

Base.round(td::TimeDate, ::Type{P}, ::RoundingMode{:Down}) where {P<:DatePeriod} = trunc(td, P)
Base.round(td::TimeDate, ::Type{P}, ::RoundingMode{:Down}) where {P<:TimePeriod} = trunc(td, P)

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

for T in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second, :Millisecond, :Microsecond)
    @eval Base.round(td::TimeDate, ::Type{$T}, ::RoundingMode{:Up}) = ceil(td, $T)
end

# RoundNearestTiesUp, round == RoundNearestTiesUp

function Base.round(td::TimeDate, ::Type{Year}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Year)
    dys = yeardays(td)
    dys = (dys >> 1) + isodd(dys)
    hlf = flr + Day(dys)
    delta = (Dates.value(td) - Dates.value(hlf)) >= 0
    flr + Year(delta)
end
function Base.round(td::TimeDate, ::Type{Month}, ::RoundingMode{:NearestTiesUp})
    flr = floor(td, Month)
    dys = monthdays(td)
    dys = (dys >> 1) + isodd(dys)
    hlf = flr + Day(dys)
    delta = (Dates.value(td) - Dates.value(hlf)) >= 0
    flr + Month(delta)
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
    flr + Millisecond(delta)
end

for T in (:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second, :Millisecond, :Microsecond)
    @eval Base.round(td::TimeDate, ::Type{$T}) = round(td, $T, RoundNearestTiesUp)
end
