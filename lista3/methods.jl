# Kinga Majcher 272354

module Methods
export mbisekcji, mstycznych, msiecznych

# Function to approximate a root of f(x) = 0 using the bisection method
# Input:
#      f: the function f(x)
#      a, b: start and end of the interval
#      delta, epsilon: precision of the calculation

# Output: (r, v, it, err)
#      r: approximation of x where f(x) = 0
#      v: value of f(r)
#      it: number of iterations performed
#      err: error code:
#           0: no error
#           1: the function does not change sign on the interval [a, b]
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    v_a::Float64 = f(a)
    v_b::Float64 = f(b)
    len::Float64 = b - a
    if sign(v_a) == sign(v_b)
        return Nothing, Nothing, Nothing, 1
    end

    k = 1
    while true
        len = len/2
        m = a + len
        v_m::Float64 = Float64(f(m))
        if abs(len) < delta || abs(v_m) < epsilon
            return m, v_m, k, 0
        end
        if sign(v_a) != sign(v_m)
            b = m
            v_b = v_m
        else
            a = m
            v_a = v_m
        end
        k = k + 1
    end
end


# Function to approximate a root of f(x) = 0 using Newton's method
# Input:
#      f: the function f(x)
#      pf: the derivative of f(x)
#      x0: initial guess for x
#      delta, epsilon: precision of the calculation
#      maxit: maximum number of iterations

# Output: (r, v, it, err)
#      r: approximation of x where f(x) = 0
#      v: value of f(r)
#      it: number of iterations performed
#      err: error code:
#           0: the method converged
#           1: the method did not achieve the required precision
#           2: the derivative is close to 0
function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    v::Float64 = f(x0)
    if abs(v) < epsilon
        return x0, v, 0, 0
    end
    for k in 1:maxit
        v_d::Float64 = pf(x0)
        if abs(v_d) < eps(Float64)
            return x0, v, k, 2
        end
        x1::Float64 = x0 - v/v_d
        v= f(x1)
        if abs(x1-x0) < delta || abs(v) < epsilon
            return x1, v, k, 0
        end
        x0 = x1
    end
    return x0, v, maxit, 1
end


# Function to approximate a root of f(x) = 0 using the Secant method
# Input:
#      f: the function f(x)
#      x0, x1: initial guesses for x
#      delta, epsilon: precision of the calculation
#      maxit: maximum number of iterations

# Output: (r, v, it, err)
#      r: approximation of x where f(x) = 0
#      v: value of f(r)
#      it: number of iterations performed
#      err: error code:
#           0: the method converged
#           1: the method did not achieve the required precision
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64,maxit::Int)
    v_x0::Float64 = f(x0)
    v_x1::Float64 = f(x1)
    for k in 1:maxit
        if abs(v_x0) > abs(v_x1)
            x0, x1 = x1, x0
            v_x0, v_x1 = v_x1, v_x0
        end
        s::Float64 = (x1 - x0)/(v_x1 - v_x0)
        x1 = x0 
        v_x1 = v_x0
        x0 = x0 - v_x0*s
        v_x0 = f(x0)
        if abs(x1 - x0) < delta || abs(v_x0) < epsilon
            return x0, v_x0, k, 0
        end
    end
    return x0, v_x0, maxit, 1
end

end