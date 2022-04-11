@testset "accessors" begin
  x = atimedate
  
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
