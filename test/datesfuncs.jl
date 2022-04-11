@testset "datesfuncs" begin

for F in (dayabbr, dayname, dayofmonth, dayofquarter,
    dayofweek, dayofweekofmonth, dayofyear, daysinmonth,
    daysinyear, daysofweekinmonth, isleapyear, monthabbr,
    monthday, monthname, quarterofyear, yearmonthday)
    a = F(atimedate)
    b = F(adate)
    @test a == b
end

for F in (firstdayofmonth, firstdayofquarter,
    firstdayofweek, firstdayofyear, lastdayofmonth,
    lastdayofquarter, lastdayofweek, lastdayofyear)
    a = F(atimedate)
    b = F(adate)
    @test a == TimeDate(b)
end

@test timedate2rata(atimedate) == datetime2rata(adatetime)
@test rata2timedate(timedate2rata(atimedate)) == TimeDate(atimedate.date)

@test Dates.value(atimedate) == Dates.value(adatetime) * Int128(NanosecondsPerMillisecond) + Dates.tons(Microsecond(atimedate)) + Dates.tons(Nanosecond(atimedate))

@test Dates.days(atimedate) == Dates.days(adatetime)
@test Dates.days(Microsecond(atimedate)) == fld(microsecond(atimedate), MicrosecondsPerDay)
@test Dates.days(Nanosecond(atimedate)) == fld(microsecond(atimedate), NanosecondsPerDay)

end
