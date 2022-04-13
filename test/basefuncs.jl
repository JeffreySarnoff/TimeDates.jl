@testset "basefuncs" begin
  @test iszero(Time(0)) == true
  @test eps(atimedate) == Nanosecond(1)
  @test DateTime(typemax(TimeDate)) == typemax(DateTime)
  @test DateTime(typemin(TimeDate)) == typemin(DateTime)
  @test repr(atimedate) == "TimeDate(\"2022-04-09T12:48:35.877012505\")"
  @test hash(atimedate) == 0xf355e41d87cf2d89
end
