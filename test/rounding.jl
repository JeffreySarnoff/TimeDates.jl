@testset "rounding" begin
    timedate1 = atimedate - Microsecond(atimedate) + Microsecond(100)
    timedate2 = atimedate - Microsecond(atimedate) + Microsecond(600)
    timedate3 = atimedate - Microsecond(atimedate) - Nanosecond(atimedate) + Microsecond(500) + Nanosecond(1)

    @test Dates.value(DateTime(trunc(atimedate, Millisecond))) == milliseconds(atimedate)
    @test Dates.value(DateTime(round(atimedate, Millisecond, RoundDown))) == milliseconds(atimedate)
    @test Dates.value(DateTime(round(atimedate, Millisecond, RoundUp))) == milliseconds(atimedate, RoundUp)

    @test Dates.value(DateTime(round(atimedate, Millisecond, RoundNearestTiesUp))) ==
          milliseconds(atimedate, RoundDown) +
          (microsecond(atimedate) * 1000 + nanosecond(atimedate) >= 500_000)

    @test Dates.value(DateTime(round(timedate1, Millisecond, RoundNearestTiesUp))) ==
          milliseconds(timedate1, RoundDown) +
          (microsecond(timedate1) * 1000 + nanosecond(timedate1) >= 500_000)
    @test Dates.value(DateTime(round(timedate2, Millisecond, RoundNearestTiesUp))) ==
          milliseconds(timedate2, RoundDown) +
          (microsecond(timedate2) * 1000 + nanosecond(timedate2) >= 500_000)
    @test Dates.value(DateTime(round(timedate3, Millisecond, RoundNearestTiesUp))) ==
          milliseconds(timedate1, RoundDown) +
          (microsecond(timedate3) * 1000 + nanosecond(timedate3) >= 500_000)

    time0 = Time(0)
    
    for period in (Year, Quarter, Month, Week)
      if period != Week
            @test trunc(atimedate, period) == TimeDate(time0, trunc(atimedate.date, period))
      end
      @test round(atimedate, period, RoundNearestTiesUp) == TimeDate(time0, round(atimedate.date, period, RoundNearestTiesUp))
      @test round(atimedate, period, RoundUp) == TimeDate(time0, round(atimedate.date, period, RoundUp))
      @test round(atimedate, period, RoundDown) == TimeDate(time0, round(atimedate.date, period, RoundDown))
      @test round(atimedate, period) == round(atimedate, period, RoundNearestTiesUp)
    end
    @test trunc(atimedate, Week) == round(atimedate, Week, RoundDown)

    for period in (Minute, Second, Millisecond, Microsecond, Nanosecond)
          @test trunc(atimedate, period) == TimeDate(trunc(atimedate.time, period), atimedate.date)
    
          @test floor(atimedate, period) == TimeDate(trunc(atimedate.time, period), atimedate.date)

          @test round(atimedate, period, RoundNearestTiesUp) == TimeDate(round(atimedate.time, period, RoundNearestTiesUp), atimedate.date)
          @test round(atimedate, period, RoundUp) == TimeDate(round(atimedate.time, period, RoundUp), atimedate.date)
          @test round(atimedate, period, RoundDown) == TimeDate(trunc(atimedate.time, period), atimedate.date)
          @test round(atimedate, period) == round(atimedate, period, RoundNearestTiesUp)
    end

    @test round(atimedate, Day, RoundNearestTiesUp) == TimeDate(time0, atimedate.date + Day(1))
    @test round(atimedate, Day, RoundUp) == TimeDate(time0, atimedate.date + Day(1))
    @test round(atimedate, Day, RoundDown) == TimeDate(time0, atimedate.date)
    @test round(atimedate, Day) == TimeDate(time0, atimedate.date + Day(1))
   
    @testset "round time" begin
      @test floor(atime, Hour) == trunc(atime, Hour)
      @test floor(atime, Nanosecond) == atime
        
      for period in (Hour, Minute, Second, Millisecond, Microsecond, Nanosecond)
            @test floor(atime, period) == trunc(atime, period)
            @test round(atime, period, RoundDown) == trunc(atime, period)
      end
    end
end
