using Test, Life

@testset "Tests are set up" begin
    @test true
end

@testset "loads a repeater pattern" begin
    r = Life.repeater()
    @test r == [
                    false false false; 
                    true  true  true; 
                    false false false
                ]
end

@testset "loads a stable pattern" begin
    s = Life.stable()
    @test s == [
                   false true  true  false; 
                   true  false false true ; 
                   true  false false true ; 
                   false true  true  false
               ]
end

@testset "retrieves cell from board" begin
    r = Life.repeater()
    @test Life.get_at(r, 2, 1)
    @test !Life.get_at(r, 1, 2)
    @test Life.get_at(r, 2, 2)
end

@testset "retrieves out of bounds as false" begin
    r = Life.repeater()
    @test !Life.get_at(r, 0, 0)
    @test !Life.get_at(r, 2, 0)
    @test !Life.get_at(r, 0, 2)
    @test !Life.get_at(r, 0, 2)
    @test !Life.get_at(r, 2, 4)
    @test !Life.get_at(r, 4, 2)
end

@testset "counts neighbors" begin
    r = Life.repeater()
    @test Life.neighbors(r, 1, 2) == 3
    @test Life.neighbors(r, 2, 2) == 2
    @test Life.neighbors(r, 2, 1) == 1
end

@testset "computes next generation cell from neighbors and current cell" begin
    # one neighbor dies
    @test Life.cell(1, true) == false
    @test Life.cell(1, false) == false

    # two neighbors stays the same
    @test Life.cell(2, true) == true
    @test Life.cell(2, false) == false

    # three neighbors comes to life
    @test Life.cell(3, true) == true
    @test Life.cell(3, false) == true

    # more than three neighbors dies
    @test Life.cell(4, true) == false
    @test Life.cell(8, false) == false
end

@testset "computes whole next generation" begin
    r = Life.repeater() |> Life.next_board
    
    @test r == [
                    false true false; 
                    false true false; 
                    false true false
                ]
                
    r2 = Life.repeater() |> Life.next_board |> Life.next_board

    @test r2 == [
                    false false false; 
                    true  true  true; 
                    false false false
                ]

end
