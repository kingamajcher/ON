# function which calculates value of sin(x) + cos(3x) for given x
# x: variable of type Float64 for which value of expression above would be calculated
# returns: caluclated value of expression for given x
function f(x::Float64)
    return sin(x) + cos(x * 3.0)
end

# function which returns aproximate value of derivative from expression (f(x + h) - f(x)) / h
# x: variable of type Float64 for which derivative would be calculated
# h: variable of type Float64 approaching zero
# returns: aproximate value of derivative of find_x
function derivative(x::Float64, h::Float64)
    return (f(x + h) - f(x)) / h
end

function compute_derivative()
    derivative_value = 0.11694228168853815 # value of derivative of f in x0 = 1 calculated externally

    h = Float64(1.0) # value of starting point of h; 2^0 = 1
    n = 0 # value of exponent of h

    while n >= -54
        calculated_value = derivative(Float64(1.0), h)
        error = abs(derivative_value - calculated_value)
        println("f'(x) = ", calculated_value, " for h = 2^", n)
        println("Computing error = ", error)
        println("1 + h: ", 1.0 + h, "\n")
        h /= 2
        n -= 1
    end
end

compute_derivative()

    
