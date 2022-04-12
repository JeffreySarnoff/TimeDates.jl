@testset "parsing" begin
    
    @testset "string(::TimeDate)" begin
        @test td1str == string(td1)
        @test td2str == string(td2)
        @test td3str == string(td3)
        @test td4str == string(td4)
    end

    @testset "subseconds" begin
        
    end
end