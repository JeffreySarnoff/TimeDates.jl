@testset "construction" begin
    @test TimeDate(atimedate) == atimedate
    @test TimeDate(atime, adate) == atimedate
    @test TimeDate(adate, atime) == atimedate
    @test TimeDate(time=atime, date=adate) == atimedate

    @test TimeDate(yr, mo, dy, hr, mn, sc, ms, us, ns) == atimedate
    @test TimeDate(ayear, amonth, aday, ahour, aminute, asecond,
        amillisecond, amicrosecond, ananosecond) == atimedate

    @test TimeDate(atime, adate) == atimedate
    @test TimeDate(adate, atime) == atimedate
    @test TimeDate(adate) == trunc(atimedate, Day)

    @test TimeDate(atime_hmsm, adate, amicrosecond, ananosecond) == atimedate
    @test TimeDate(adate, atime_hmsm, amicrosecond, ananosecond) == atimedate

    @test TimeDate(atime_hmsm, adate, us, ns) == atimedate
    @test TimeDate(atime_hmsm, adate, amicrosecond, ananosecond) == atimedate
    @test TimeDate(adate, atime_hmsm, us, ns) == atimedate
    @test TimeDate(adate, atime_hmsm, amicrosecond, ananosecond) == atimedate
end

@testset "construction from conversion" begin
    @testset "from DateTime" begin
        @test TimeDate(adatetime) == atimedate - amicrosecond - ananosecond

        @test TimeDate(adatetime, amicrosecond, ananosecond) == atimedate
        @test TimeDate(adatetime, us) == atimedate - ananosecond
    end

    @testset "from Date" begin
        @test TimeDate(adate) == TimeDate(Time(0,0,0,0,0,0), adate)
    end
end