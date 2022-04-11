@testset "namedtuples" begin

    @testset "accessors: TimeDatePeriods" begin
        x = periods(atimedate)

        @test x.year == yr
        @test x.month == mo
        @test x.day == dy
        @test x.hour == hr
        @test x.minute == mn
        @test x.second == sc
        @test x.millisecond == ms
        @test x.microsecond == us
        @test x.nanosecond == ns

        @test year(x) == yr
        @test month(x) == mo
        @test day(x) == dy
        @test hour(x) == hr
        @test minute(x) == mn
        @test second(x) == sc
        @test millisecond(x) == ms
        @test microsecond(x) == us
        @test nanosecond(x) == ns

        @test Year(x) == Year(yr)
        @test Month(x) == Month(mo)
        @test Day(x) == Day(dy)
        @test Hour(x) == Hour(hr)
        @test Minute(x) == Minute(mn)
        @test Second(x) == Second(sc)
        @test Millisecond(x) == Millisecond(ms)
        @test Microsecond(x) == Microsecond(us)
        @test Nanosecond(x) == Nanosecond(ns)
    end

    @testset "accessors: DateTimePeriods" begin
        x = periods(atimedate)

        @test x.year == yr
        @test x.month == mo
        @test x.day == dy
        @test x.hour == hr
        @test x.minute == mn
        @test x.second == sc
        @test x.millisecond == ms

        @test year(x) == yr
        @test month(x) == mo
        @test day(x) == dy
        @test hour(x) == hr
        @test minute(x) == mn
        @test second(x) == sc
        @test millisecond(x) == ms

        @test Year(x) == Year(yr)
        @test Month(x) == Month(mo)
        @test Day(x) == Day(dy)
        @test Hour(x) == Hour(hr)
        @test Minute(x) == Minute(mn)
        @test Second(x) == Second(sc)
        @test Millisecond(x) == Millisecond(ms)
    end

    @testset "accessors: DatePeriods" begin
        x = periods(atimedate)

        @test x.year == yr
        @test x.month == mo
        @test x.day == dy

        @test year(x) == yr
        @test month(x) == mo
        @test day(x) == dy

        @test Year(x) == Year(yr)
        @test Month(x) == Month(mo)
        @test Day(x) == Day(dy)
    end

    @testset "accessors: TimePeriods" begin
        x = periods(atimedate)

        @test x.hour == hr
        @test x.minute == mn
        @test x.second == sc
        @test x.millisecond == ms
        @test x.microsecond == us
        @test x.nanosecond == ns

        @test hour(x) == hr
        @test minute(x) == mn
        @test second(x) == sc
        @test millisecond(x) == ms
        @test microsecond(x) == us
        @test nanosecond(x) == ns

        @test Hour(x) == Hour(hr)
        @test Minute(x) == Minute(mn)
        @test Second(x) == Second(sc)
        @test Millisecond(x) == Millisecond(ms)
        @test Microsecond(x) == Microsecond(us)
        @test Nanosecond(x) == Nanosecond(ns)
    end
end
