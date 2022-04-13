@testset "parsing" begin

    @testset "string(::TimeDate)" begin
        @test td1str == string(td1)
        @test td2str == string(td2)
        @test td3str == string(td3)
        @test td4str == string(td4)
    end

    @testset "subseconds" begin
        @test TimeDate(atimedate_str, dateformat"y-m-dTH:M:S.sss") == atimedate
        @test TimeDate(atimedate_str, dateformat"y-m-dTH:M:S.ss") == atimedate - Nanosecond(atimedate)
        @test TimeDate(atimedate_str, dateformat"y-m-dTH:M:S.s") == atimedate - Nanosecond(atimedate) - Microsecond(atimedate)
        @test TimeDate(atimedate_str, dateformat"y-m-dTH:M:S") == atimedate - Nanosecond(atimedate) - Microsecond(atimedate) - Millisecond(atimedate)

        @test TimeDate(atimedate_str[1:end-3], dateformat"y-m-dTH:M:S.sss") == atimedate - Nanosecond(atimedate)
        @test TimeDate(atimedate_str[1:end-6], dateformat"y-m-dTH:M:S.sss") == atimedate - Nanosecond(atimedate) - Microsecond(atimedate)

        @test TimeDates.ymdhms_subsec(string(adate)) == ("2022-04-09", "")

        @test TimeDates.subseconds(string(123_456_789_499), 4) ==
            Millisecond(123) + Microsecond(456) + Nanosecond(789)
        @test TimeDates.subseconds(string(123_456_789_500), 4) ==
            Millisecond(123) + Microsecond(456) + Nanosecond(790)
    end

    @test TimeDate(("2022", "04", "09")) == TimeDate(adate)
    @test TimeDate(("2022", "04", "09", "12", "48", "35", "877", "012", "505")) == atimedate
end