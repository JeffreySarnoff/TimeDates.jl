@testset "compare" begin
    @test atimedate == atimedate
    @test atimedate >= atimedate
    @test atimedate <= atimedate

    @test later_timedate != earlier_timedate
    @test later_timedate >= earlier_timedate
    @test later_timedate > earlier_timedate
    @test earlier_timedate <= later_timedate
    @test earlier_timedate < later_timedate

    @test isequal(atimedate, atimedate)
    @test isless(earlier_timedate, later_timedate)
end
