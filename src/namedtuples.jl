# additional functionality (NamedTuples)

const DatePeriods = NamedTuple{(:year, :month, :day),NTuple{3,Int}}
const TimePeriods = NamedTuple{(:hour, :minute, :second, :millisecond, :microsecond, :nanosecond),NTuple{6,Int}}
const DateTimePeriods = NamedTuple{(:year, :month, :day, :hour, :minute, :second, :millisecond),NTuple{7,Int}}
const TimeDatePeriods = NamedTuple{(:year, :month, :day, :hour, :minute, :second, :millisecond, :microsecond, :nanosecond),NTuple{9,Int}}

periods(x::Date) = DatePeriods((year(x), month(x), day(x)))
periods(x::Time) =
    TimePeriods((hour(x), minute(x), second(x),
        millisecond(x), microsecond(x), nanosecond(x)))
periods(x::DateTime) =
    DateTimePeriods((year(x), month(x), day(x),
        hour(x), minute(x), second(x), millisecond(x)))
periods(x::TimeDate) =
    TimeDatePeriods((year(x), month(x), day(x),
        hour(x), minute(x), second(x),
        millisecond(x), microsecond(x), nanosecond(x)))

for T in (:DatePeriods, :TimePeriods, :DateTimePeriods, :TimeDatePeriods)
    @eval begin
        Base.zero(::$T) = $T(ntuple(z -> 0, fieldcount($T)))
        Base.iszero(x::$T) = x === zero($T)
    end
end

const ZeroTuples = Tuple(ntuple(z -> 0, n) for n = 1:9)

Dates.Time(x::TimePeriods) = Time(x...)
Dates.Time(x::DatePeriods) = Time0
Dates.Time(x::DateTimePeriods) = Time(x.hour, x.minute, x.second, x.millisecond)
Dates.Time(x::TimeDatePeriods) = Time(x.hour, x.minute, x.second, x.millisecond, x.microsecond, x.nanosecond)

Dates.Date(x::DatePeriods) = Date(x...)
Dates.Date(x::DateTimePeriods) = Date(x.year, x.month, x.day)
Dates.Date(x::TimeDatePeriods) = Date(x.year, x.month, x.day)

Dates.DateTime(x::DateTimePeriods) = DateTime(values(x)...)
Dates.DateTime(x::DatePeriods) = DateTime(x.year, x.month, x.day)
Dates.DateTime(x::TimeDatePeriods) = DateTime(x.year, x.month, x.day, x.hour, x.minute, x.second, x.millisecond)

TimeDate(x::DatePeriods) = TimeDate(x...)
TimeDate(x::TimeDatePeriods) = TimeDate(x...)
TimeDate(x::DateTimePeriods) = TimeDate(x...)

# allow access to periods that are zero by definition
# this simplifies transportablity

Dates.nanosecond(x::DatePeriods) = Int64(0)
Dates.millisecond(x::DatePeriods) = Int64(0)
Dates.microsecond(x::DatePeriods) = Int64(0)
Dates.second(x::DatePeriods) = Int64(0)
Dates.minute(x::DatePeriods) = Int64(0)
Dates.hour(x::DatePeriods) = Int64(0)
Dates.Nanosecond(x::DatePeriods) = Nanosecond(0)
Dates.Millisecond(x::DatePeriods) = Millisecond(0)
Dates.Microsecond(x::DatePeriods) = Microsecond(0)
Dates.Second(x::DatePeriods) = Second(0)
Dates.Minute(x::DatePeriods) = Minute(0)
Dates.Hour(x::DatePeriods) = Hour(0)
Dates.day(x::TimePeriods) = Int64(0)
Dates.month(x::TimePeriods) = Int64(0)
Dates.year(x::TimePeriods) = Int64(0)
Dates.Day(x::TimePeriods) = Day(0)
Dates.Month(x::TimePeriods) = Month(0)
Dates.Year(x::TimePeriods) = Year(0)
Dates.nanosecond(x::DateTimePeriods) = Int64(0)
Dates.microsecond(x::DateTimePeriods) = Int64(0)
Dates.Nanosecond(x::DateTimePeriods) = Nanosecond(0)
Dates.Microsecond(x::DateTimePeriods) = Microsecond(0)


for T in (:DatePeriods, :DateTimePeriods, :TimeDatePeriods)
    for period in (:Year, :Month, :Day)
        accessor = Symbol(lowercase(string(period)))
        @eval begin
            Dates.$accessor(x::$T) = x.$accessor
            Dates.$period(x::$T) = $period(x.$accessor)
        end
    end
end

for T in (:TimePeriods, :DateTimePeriods, :TimeDatePeriods)
    for period in (:Hour, :Minute, :Second, :Millisecond)
        accessor = Symbol(lowercase(string(period)))
        @eval begin
            Dates.$accessor(x::$T) = x.$accessor
            Dates.$period(x::$T) = $period(x.$accessor)
        end
    end
end

for T in (:TimePeriods, :TimeDatePeriods)
    for period in (:Microsecond, :Nanosecond)
        accessor = Symbol(lowercase(string(period)))
        @eval begin
            Dates.$accessor(x::$T) = x.$accessor
            Dates.$period(x::$T) = $period(x.$accessor)
        end
    end
end

for (T, S) in ((:TimeDatePeriods, :TimeDate), (:DateTimePeriods, :DateTime))
    for period in (:Year, :Month, :Day, :Hour, :Minute, :Second,
        :Millisecond, :Microsecond, :Nanosecond)
        @eval begin
            function Base.:(+)(x::$T, p::$period)
                td = $S(x)
                td = td + p
                periods(td)
            end
            Base.:(+)(p::$period, x::$T) = x + p
            function Base.:(-)(x::$T, p::$period)
                td = $S(x)
                td = td - p
                periods(td)
            end
        end
    end
end

for (T, S) in ((:TimePeriods, :Time),)
    for period in (:Hour, :Minute, :Second, :Millisecond, :Microsecond, :Nanosecond)
        @eval begin
            function Base.:(+)(x::$T, p::$period)
                td = $S(x)
                td = td + p
                periods(td)
            end
            Base.:(+)(p::$period, x::$T) = x + p
            function Base.:(-)(x::$T, p::$period)
                td = $S(x)
                td = td - p
                periods(td)
            end
        end
    end
end

for (T, To) in ((:TimePeriods, :Time), (:DatePeriods, :Date),
    (:DateTimePeriods, :DateTime), (:TimeDatePeriods, :TimeDate))
    @eval begin
        Base.:(+)(x::$T, y::CompoundPeriod) = reduce(+, y.periods; init=x)
        Base.:(+)(x::CompoundPeriod, y::$T) = reduce(+, x.periods; init=y)
        Base.:(-)(x::$T, y::CompoundPeriod) = reduce(-, y.periods; init=x)

        Base.:(-)(x::$T, y::$T) = $To(x) - $To(y)
    end
end
