@testset "arithmetic" begin
    @test (atimedate + Day(7)) - atimedate == Day(7)

    @test atimedate - (atimedate - Day(2) + Nanosecond(5)) ==
          Day(1) + Hour(23) + Minute(59) + Second(59) + 
          Millisecond(999) + Microsecond(999) + Nanosecond(995)

    p = (Week, Day, Hour, Minute, Second, Millisecond, Microsecond, Nanosecond)
    q = map(x -> x(1), p)
    r = map(x -> tons(x), q)
    s = map(x -> atimedate + x, q)
    t = map(x -> value(x), s)
    u = value(atimedate)
    v = map(x -> u + x, r)
    @test all(v .== t)

    s = map(x -> x + atimedate, q)
    t = map(x -> value(x), s)
    u = value(atimedate)
    v = map(x -> u + x, r)
    @test all(v .== t)

    s = map(x -> atimedate - x, q)
    t = map(x -> value(x), s)
    u = value(atimedate)
    v = map(x -> u - x, r)
    @test all(v .== t)

    p = (Year, Quarter, Month)
    q = map(x -> x(1), p)
    s = map(x -> atimedate + x, q)
    t = map((x, y) -> y - x, q, s)
    @test all(atimedate .== t)

    s = map(x -> x + atimedate, q)
    t = map((x, y) -> y - x, q, s)
    @test all(atimedate .== t)

    s = map(x -> atimedate - x, q)
    t = map((x, y) -> y + x, q, s)
    @test all(atimedate .== t)

    @test (atimedate - adatetime) == Microsecond(atimedate) + Nanosecond(atimedate)
    @test atime - (atimedate - adate) == Time(0, 0, 0)
    @test atime + (adate - atimedate) == Time(0, 0, 0)

    @test atimedate - later_timedate == Day(-1) + Minute(-1) + Nanosecond(-1)
end
