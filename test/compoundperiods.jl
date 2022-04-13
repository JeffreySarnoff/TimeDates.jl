@testset "compound periods" begin
    compound = Minute(1) + Second(10)

    @test Nanosecond(compound) == Nanosecond(70_000_000_000)
    @test Millisecond(compound) == Millisecond(70_000)
    @test zero(compound) = Minute(0) + Second(0)
    @test isempty(zero(compound)) == true

    @test signbit(Minute(1)) == false
    @test signbit(Minute(-1)) == true
    @test signbit(compound) == false
    @test signbit(-compound) == true
    @test signbit(zero(compound)) == true

    @test sign(compound) == 1
    @test sign(-compound) == -1
    @test sign(zero(compound)) == 0

    @test Dates.toms(compound) == Millisecond(compound)
    @test Dates.tons(compound) == Nanosecond(compound)
    @test TimeDates.tonanos(compound) = 70_000_000_000
    @test Dates.value(compound) == TimeDates.tonanos(compound)

    @test iterate(compound) == (Minute(1), 2)
    @test iterate(compound,2) == (Second(10), 3)
end
