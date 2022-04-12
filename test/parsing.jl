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
    end

end