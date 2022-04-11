@testset "parsing" begin
    
    @testset "string(::TimeDate)" begin
        @test td1str == string(td1)
        @test td2str == string(td2)
        @test td3str == string(td3)
        @test td4str == string(td4)
    end

    @testset "DateTime(::TimeDate)" begin
        @test dt1 == DateTime(td1)
        @test dt2 == DateTime(td2)
        @test dt3 == DateTime(td3)
        @test dt4 == DateTime(td4)

        @test dt1 == td1 - Microsecond(td1) - Nanosecond(td1)
        @test dt2 == td2 - Microsecond(td2) - Nanosecond(td2)
        @test dt3 == td3 - Microsecond(td3) - Nanosecond(td3)
        @test dt4 == td4 - Microsecond(td4) - Nanosecond(td4)
    end

end