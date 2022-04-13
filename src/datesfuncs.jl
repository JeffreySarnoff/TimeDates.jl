for F in (:dayabbr, :dayname, :dayofmonth, :dayofquarter,
    :dayofweek, :dayofweekofmonth, :dayofyear, :daysinmonth,
    :daysinyear, :daysofweekinmonth, :isleapyear, :monthabbr,
    :monthday, :monthname, :quarterofyear, :yearmonthday)
    @eval Dates.$F(td::TimeDate) = $F(td.date)
end

for F in (:firstdayofmonth, :firstdayofquarter,
    :firstdayofweek, :firstdayofyear, :lastdayofmonth,
    :lastdayofquarter, :lastdayofweek, :lastdayofyear)
    @eval Dates.$F(td::TimeDate) = TimeDate(Time0, $F(td.date))
end

# tofirst, tolast, toprev, tonext just work with TimeDate

timedate2rata(x::TimeDate) = datetime2rata(DateTime(x))
rata2timedate(x::Int64) = TimeDate(rata2datetime(x))

# extend these unexported functions

Dates.days(x::TimeDate) = days(x.date)
Dates.days(x::Microsecond) = div(value(x), MicrosecondsPerDay)
Dates.days(x::Nanosecond) = div(value(x), NanosecondsPerDay)

Dates.value(x::TimeDate) =
    Int128(NanosecondsPerDay) * Dates.value(x.date) + Dates.value(x.time)
