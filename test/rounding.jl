@testset "rounding" begin
    timedate1 = atimedate - Microsecond(atimedate) + Microsecond(100)
    timedate2 = atimedate - Microsecond(atimedate) + Microsecond(600)
    timedate3 = atimedate - Microsecond(atimedate) - Nanosecond(atimedate) + Microsecond(500) + Nanosecond(1)

    @test value(DateTime(trunc(atimedate, Millisecond))) == milliseconds(atimedate)
    @test value(DateTime(round(atimedate, Millisecond, RoundDown))) == milliseconds(atimedate)
    @test value(DateTime(round(atimedate, Millisecond, RoundUp))) == milliseconds(atimedate, RoundUp)

    @test value(DateTime(round(atimedate, Millisecond, RoundNearestTiesUp))) ==
          milliseconds(atimedate, RoundDown) +
          (microsecond(atimedate) * 1000 + nanosecond(atimedate) >= 500_000)

    @test value(DateTime(round(timedate1, Millisecond, RoundNearestTiesUp))) ==
          milliseconds(timedate1, RoundDown) +
          (microsecond(timedate1) * 1000 + nanosecond(timedate1) >= 500_000)
    @test value(DateTime(round(timedate2, Millisecond, RoundNearestTiesUp))) ==
          milliseconds(timedate2, RoundDown) +
          (microsecond(timedate2) * 1000 + nanosecond(timedate2) >= 500_000)
    @test value(DateTime(round(timedate3, Millisecond, RoundNearestTiesUp))) ==
          milliseconds(timedate1, RoundDown) +
          (microsecond(timedate3) * 1000 + nanosecond(timedate3) >= 500_000)

      time0 = Time(0)
      for period in (Year, Quarter, Month, Week)
            @test Base.trunc(atimedate, period) == TimeDate(time0, trunc(td.date, period))

            @test Base.round(atimedate, period, RoundNearestTiesUp) == TimeDate(time0, round(td.date, period, RoundNearestTiesUp))
            @test Base.round(atimedate, period, RoundUp) == TimeDate(time0, round(td.date, period, RoundUp))
            @test Base.round(atimedate, period, RoundDown) == TimeDate(time0, round(td.date, period, RoundDown))
            @test Base.round(atimedate, period) == round(atimedate, period, RoundNearestTiesUp)
      end

end
