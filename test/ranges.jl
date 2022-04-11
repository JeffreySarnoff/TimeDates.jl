@testset "ranges" begin
    adatetime_range = collect(adatetime:Day(1):adatetime+Day(5))
    atimedate_range = collect(atimedate:Day(1):atimedate+Day(5))

    @test all(adatetime_range .== DateTime.(atimedate_range))

    start = TimeDate(2000)
    stop = TimeDate(2000) + Month(3)
    step = Day(40) + Hour(12)
    ranged = collect(start:step:stop)
    @test length(ranged) == 3
    @test ranged[end] == TimeDate(Time(0), Date(2000, 3, 22))

    start = DateTime(start)
    stop = DateTime(stop)
    ranged = collect(start:step:stop)
    @test length(ranged) == 3
    @test ranged[end] == DateTime(Date(2000, 3, 22))
end
