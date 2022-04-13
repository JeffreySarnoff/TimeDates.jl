@testset "compound periods" begin
    compound = Minute(1) + Second(10)

    @test Nanosecond(compound) == Nanosecond(70_000_000_000)
    @test Millisecond(compound) == Millisecond(70_000)

    @test isempty(Minute(0) + Second(0)) == true

    @test signbit(Minute(1)) == false
    @test signbit(Minute(-1)) == true
    @test signbit(compound) == false
    @test signbit(-compound) == true

    @test sign(compound) == 1
    @test sign(-compound) == -1

    @test Dates.toms(compound) == 70_000
    @test Dates.tons(compound) == 70_000_000_000
    @test TimeDates.tonanos(compound) == 70_000_000_000
    @test Dates.value(compound) == TimeDates.tonanos(compound)

    @test compound * 2 == Minute(2) + Second(20)
    @test 2 * compound == Minute(2) + Second(20)
    @test abs(compound) == compound
    @test abs(-compound) == compound

    @test iterate(compound) == (Minute(1), 2)
    @test iterate(compound, 2) == (Second(10), 3)
end
