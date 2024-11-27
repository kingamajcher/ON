# Kinga Majcher 272354 

include("methods.jl")
using .Methods
using Test

epsilon = delta = 10^(-5)

@testset "$(rpad("Bisection Method", 20))" begin
  # Basic example of a function and paramethers, for which method should work correctly
  f = x -> 0.5*x^2 - x
  correctResult = 2
  result = mbisekcji(f, 1.1, 3.0, delta, epsilon)
  x = result[1]
  fx = result[2]
  err = result[4]
  @test abs(fx) <= epsilon
  @test abs(correctResult - x) <= delta
  @test err == 0

 
  # Example where the interval does not have a sign change
  result = mbisekcji(f, 0.1, 1.0, delta, epsilon)
  x = result[1]
  fx = result[2]
  it = result[3]
  err = result[4]
  @test fx == Nothing
  @test x == Nothing
  @test it == Nothing
  @test err == 1

  # Example where the root is exactly in the middle of the interval
  result = mbisekcji(f, 1.5, 2.5, delta, epsilon)
  x = result[1]
  fx = result[2]
  it = result[3]
  err = result[4]
  @test fx == 0
  @test x == 2
  @test it == 1
  @test err == 0
end

@testset "$(rpad("Newton's Method", 20))" begin
  # Basic example of a function and paramethers, for which method should work correctly
  f = x -> 0.5*x^3 - 4
  pf = x -> 1.5*x^2
  correctResult = 2.0
  result = mstycznych(f, pf, 0.5, delta, epsilon, 10)
  x = result[1]
  fx = result[2]
  err = result[4]
  @test abs(fx) < epsilon
  @test abs(correctResult-x) < delta
  @test err == 0

  # Example where initial approximation of x is such that the derivative is 0
  f = x -> 0.5*x^3 - 4
  pf = x -> 1.5*x^2
  result = mstycznych(f, pf, 0.0, delta, epsilon, 10)
  err = result[4]
  @test err == 2

  # Example where method does not converge
  f = x -> 0.5*x^3 - x + 2
  pf = x -> 1.5*x^2 - 1
  result = mstycznych(f, pf, 0.0, delta, epsilon, 10)
  x = result[1]
  fx = result[2]
  it = result[3]
  err = result[4]
  @test abs(fx) > epsilon
  @test abs(x-0) > delta
  @test it == 10
  @test err == 1
end

@testset "$(rpad("Secant Method", 20))" begin
  # Basic example of a function and paramethers, for which method should work correctly
  f = x -> x^2 - x
  correctResult = 1.0
  result = msiecznych(f, 1.5, 1.7, delta, epsilon, 10)
  x = result[1]
  fx = result[2]
  err = result[4]
  @test abs(fx) < epsilon
  @test abs(correctResult-x) < delta
  @test err == 0

  # Example of function with horizontal secant given (method does not converge)
  f = x -> x^2
  result = msiecznych(f, -1.0, 1.0, delta, epsilon, 50)
  x = result[1]
  fx = result[2]
  it = result[3]
  err = result[4]
  @test isnan(fx)
  @test isnan(x)
  @test it == 50
  @test err == 1
end