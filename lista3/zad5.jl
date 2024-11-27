# Kinga Majcher 272354

include("methods.jl")
using .Methods

# method that calculates root of a function f and prints it using bisection method
# a, b: ends of an interval
function calculate(a, b)
    f = x -> 3*x - (MathConstants.e)^x
    delta = epsilon = 10^(-4)
    r, v, it, err = mbisekcji(f, a, b, delta, epsilon)
    println("calculated root:                       ", r)
    println("value of function for calculated root: ", v) 
    println("number of iterations:                  ", it)
    println("type of error:                         ", err)
    println()
end

calculate(0.0, 1.0)
calculate(1.0, 2.0)