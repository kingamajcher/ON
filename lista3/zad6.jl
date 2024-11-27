# Kinga Majcher 272354

include("methods.jl")
using .Methods

# method that calculates root of a function f and prints it using bisection method
# f: the function f(x)
# a, b: start and end of the interval
# delta, epsilon: precision of the calculation
function calculate1(f, a, b, delta, epsilon)
    r, v, it, err = mbisekcji(f, a, b, delta, epsilon)
    println("calculated root:                       ", r)
    println("value of function for calculated root: ", v) 
    println("number of iterations:                  ", it)
    println("type of error:                         ", err)
    println()
end

# method that calculates root of a function f and prints it using Newton's method
# f: the function f(x)
# pf: the derivative of f(x)
# x0: initial guess for x
# delta, epsilon: precision of the calculation
# maxit: maximum number of iterations
function calculate2(f, pf, x0, delta, epsilon, maxit)
    r, v, it, err = mstycznych(f, pf, x0, delta, epsilon, maxit)
    println("calculated root:                       ", r)
    println("value of function for calculated root: ", v) 
    println("number of iterations:                  ", it)
    println("type of error:                         ", err)
    println()
end

# method that calculates root of a function f and prints it using secant method
# f: the function f(x)
# x0, x1: initial guesses for x
# delta, epsilon: precision of the calculation
# maxit: maximum number of iterations
function calculate3(f, x0, x1, delta, epsilon, maxit)
    r, v, it, err = msiecznych(f, x0, x1, delta, epsilon, maxit)
    println("calculated root:                       ", r)
    println("value of function for calculated root: ", v) 
    println("number of iterations:                  ", it)
    println("type of error:                         ", err)
    println()
end


f1 = x -> (MathConstants.e)^(1-x) - 1
f2 = x -> x*(MathConstants.e)^(-x)

pf1 = x -> -(MathConstants.e)^(1-x)
pf2 = x -> -(MathConstants.e)^(-x)*(x-1)

delta = epsilon = 10^(-5)

println("f1(x) = e^(1-x) - 1\n")
println("Bisection Method: ")
calculate1(f1, 0.0, 2.0, delta, epsilon)

println("Newton's Method: ")
calculate2(f1, pf1, 2.0, delta, epsilon, 20)

println("Secant Method: ")
calculate3(f1, 0.0, 0.5, delta, epsilon, 20)
println()

println("-------------------------------------------------------------")

println("f2(x) = x*e^(-x)\n")
println("Bisection Method: ")
calculate1(f2, -1.0, 1.0, delta, epsilon)

println("Newton's Method: ")
calculate2(f2, pf2, -0.1, delta, epsilon, 20)

println("Secant Method: ")
calculate3(f2, 1.0, 0.5, delta, epsilon, 20)