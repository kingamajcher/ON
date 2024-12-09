# Kinga Majcher 272354

include("interpolation.jl")
using .Interpolation
using Test
using Plots

@testset "Testy modułu interpolacji" begin

  @testset "Interpolacja funkcji liniowej" begin
    x = [0.0, 1.0]
    f = [1.0, 3.0]
    fx = ilorazyRoznicowe(x, f)
    
    @test fx[1] == 1.0
    @test fx[2] == 2.0
    @test warNewton(x, fx, 0.5) == 2.0 
    @test warNewton(x, fx, -1.0) == -1.0
  end

  @testset "Interpolacja funkcji z dużymi wartościami" begin
    f = x -> 10^6 * x^2 - 2 * 10^6 * x + 10^6
    x = [-2.0, -1.0, 0.0, 1.0, 2.0]
    f_values = [f(xi) for xi in x]
    fx = ilorazyRoznicowe(x, f_values)
    
    @test warNewton(x, fx, 0.5) == f(0.5)
    @test warNewton(x, fx, -1.5) == f(-1.5)
    @test warNewton(x, fx, 1.5) == f(1.5)
  end

  @testset "Interpolacja funkcji zerowej" begin
    f = x -> 0.0
    x = [-2.0, -1.0, 0.0, 1.0, 2.0]
    f_values = [f(xi) for xi in x]
    fx = ilorazyRoznicowe(x, f_values)
    
    @test fx[1] == 0.0
    @test fx[2] == 0.0
    @test fx[3] == 0.0
    @test fx[4] == 0.0
    @test fx[5] == 0.0
    @test warNewton(x, fx, 0.0) == 0.0
    @test warNewton(x, fx, -1.5) == 0.0
  end

  @testset "Interpolacja funkcji kwadratowej" begin
    f = x -> x^2
    x = [0.0, 1.0, 2.0, -1.0]
    f_values = [0.0, 1.0, 4.0, 1.0]
    fx = ilorazyRoznicowe(x, f_values)
    @test fx[1] == 0.0
    @test fx[2] == 1.0
    @test fx[3] == 1.0
    @test fx[4] == 0.0
  end

  @testset "Interpolacja wielomianu stopnia trzeciego" begin
    f = x -> 2*x^3 + x + 1
    x = [-1.0, 0.0, 1.0, 2.0]
    f_values = [-2.0, 1.0, 4.0, 19.0]
    fx = ilorazyRoznicowe(x, f_values)
    @test fx[1] == -2.0
    @test fx[2] == 3.0
    @test fx[3] == 0.0
    @test fx[4] == 2.0
    @test warNewton(x, fx, -2.0) == f(-2.0)
    @test warNewton(x, fx, 10.0) == f(10.0)
  end

  @testset "Interpolacja dla wartości z zadania 4 z listy 4 z ćwiczeń" begin
    x = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
    f = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]
    fx = ilorazyRoznicowe(x, f)
    @test fx[1] == -25
    @test fx[2] == 28
    @test fx[3] == -15
    @test fx[4] == 5
    @test fx[5] == 0
    @test fx[6] == 1
    wspolczynniki = naturalna(x, fx)
    @test wspolczynniki[1] == 1.0
    @test wspolczynniki[2] == -3.0
    @test wspolczynniki[3] == 0.0
    @test wspolczynniki[4] == 0.0
    @test wspolczynniki[5] == 0.0
    @test wspolczynniki[6] == 1.0
  end

end
