# Kinga Majcher 272354

using Printf

# function calculating value of p_{n+1} using p_{n+1} = p_n + r*p_n*(1_p) in Float32 arithmetic
# p: current value of p_n in Float32
# r: value of r in Float32
# returns: value of p_{n+1} in Float32
function nextPFloat32(p::Float32, r::Float32)::Float32
    return p + r*p*(1 - p)
end

# function calculating value of p_{n+1} using p_{n+1} = p_n + r*p_n*(1_p) in Float64 arithmetic
# p: current value of p_n in Float64
# r: value of r in Float64
# returns: value of p_{n+1} in Float64
function nextPFloat64(p::Float64, r::Float64)::Float64
    return p + r*p*(1 - p)
end

# function, which is conducting experiment 1: doing 40 iterations of calculating p_n and doing 10 iterations of calculating p_n, rounding it up to three decimal places and doing another 30 iterations (all in Float32); then printing results in table
function experiment1()
    println("experiment 1:")
    p = Float32(0.01)
    r = Float32(3.0)
    results1 = zeros(Float32, 40)
    results2 = zeros(Float32, 40)

    for i in 1:40
        p = nextPFloat32(p, r)
        results1[i] = p
    end

    p = Float32(0.01)
    for i in 1:10
        p = nextPFloat32(p, r)
        results2[i] = p
    end
    p = Float32(0.722)
    results2[10] = p
    for i in 11:40
        p = nextPFloat32(p, r)
        results2[i] = p
    end

    println("-----------------------------------------------------------------")
    @printf("| %-15s | %-20s | %-20s |\n", "Iteration num n", "p_n", "p_n with cut")
    println("-----------------------------------------------------------------")
    for i in 1:40
        @printf("| %-15s | %-20s | %-20s |\n", i, results1[i], results2[i])
    end
    println("-----------------------------------------------------------------\n")
end

# function, which is conducting experiment 1: doing 40 iterations of calculating p_n in Float32 and doing 40 iterations of calculating p_n in Float64; then printing results in table
function experiment2()
    println("experiment 2:")
    p = Float32(0.01)
    r = Float32(3.0)
    results1 = zeros(Float32, 40)
    results2 = zeros(Float64, 40)

    for i in 1:40
        p = nextPFloat32(p, r)
        results1[i] = p
    end

    p = Float64(0.01)
    r = Float64(3.0)
    for i in 1:40
        p = nextPFloat64(p, r)
        results2[i] = p
    end

    println("----------------------------------------------------------------------")
    @printf("| %-15s | %-20s | %-25s |\n", "Iteration num n", "p_n in Float32", "p_n in Float64")
    println("----------------------------------------------------------------------")
    for i in 1:40
        @printf("| %-15s | %-20s | %-25s |\n", i, results1[i], results2[i])
    end
    println("----------------------------------------------------------------------\n")
end

experiment1()
experiment2()
