# Kinga Majcher 272354

include("methods.jl")
using .Methods

# method that calculates root of a function f and prints it using bisection method
function calculate1()
    f = x -> sin(x) - (0.5*x)^2
    a = 1.5
    b = 2.0
    delta = epsilon = 0.5*10^(-5)
    r, v, it, err = mbisekcji(f, a, b, delta, epsilon)
    println("calculated root:                       ", r)
    println("value of function for calculated root: ", v) 
    println("number of iterations:                  ", it)
    println("type of error:                         ", err)
    println()
    return r, v
end

# method that calculates root of a function f and prints it using Newton's method
function calculate2()
    f = x -> sin(x) - (0.5*x)^2
    pf = x -> cos(x) - 0.5*x
    x0 = 1.5
    delta = epsilon = 0.5*10^(-5)
    r, v, it, err = mstycznych(f, pf, x0, delta, epsilon, 20)
    println("calculated root:                       ", r)
    println("value of function for calculated root: ", v) 
    println("number of iterations:                  ", it)
    println("type of error:                         ", err)
    println()
    return r, v
end

# method that calculates root of a function f and prints it using secant method
function calculate3()
    f = x -> sin(x) - (0.5*x)^2
    x0 = 1.0
    x1 = 2.0
    delta = epsilon = 0.5*10^(-5)
    r, v, it, err = msiecznych(f, x0, x1, delta, epsilon, 20)
    println("calculated root:                       ", r)
    println("value of function for calculated root: ", v) 
    println("number of iterations:                  ", it)
    println("type of error:                         ", err)
    println()
    return r, v
end

# function that compares results returned by iterative methods and prints which one was closest to real solution
function compareResults(r1, r2, r3)
    results = [(abs(r1), 1), (abs(r2), 2), (abs(r3), 3)]
    
    resultsSorted = sort(results, by=x->x[1])
    bestIndex = resultsSorted[1][2]
    if bestIndex == 1
        println("Best result is for Bisection Method")
    elseif bestIndex == 2
        println("Best result is for Newton's Method")
    elseif bestIndex == 3
        println("Best result is for Secant Method")
    end
end

r1, v1 = calculate1()
r2, v2 = calculate2()
r3, v3 = calculate3()
compareResults(v1, v2, v3)