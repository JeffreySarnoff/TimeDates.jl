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

    @test isequal(adate, atimedate) == false
    @test isequal(TimeDate(adate), adate) == true
    @test isequal(adatetime, atimedate) == false
    @test isequal(TimeDate(adatetimed), adatetime) == true

    @test isless(adate, atimedate) == true
    @test isless(TimeDate(adate), adate) == false
    @test isless(adatetime, atimedate) == true
    @test isless(TimeDate(adatetimed), adatetime) == false

    @test ==(adate, atimedate) == false
    @test ==(TimeDate(adate), adate) == true
    @test ==(adatetime, atimedate) == false
    @test ==(TimeDate(adatetimed), adatetime) == true

    @test <(adate, atimedate) == true
    @test <(TimeDate(adate), adate) == false
    @test <(adatetime, atimedate) == true
    @test <(TimeDate(adatetimed), adatetime) == false

    @test <=(adate, atimedate) == true
    @test <=(TimeDate(adate), adate) == false
    @test <=(adatetime, atimedate) == true
    @test <=(TimeDate(adatetimed), adatetime) == false
end
