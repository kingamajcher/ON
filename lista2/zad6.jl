# Kinga Majcher 272354

using Printf

# values of c used in experiment
global c = [-2, -2, -2, -1, -1, -1, -1]

#values of x_0 used in experiment
global x0 = [1, 2, 1.99999999999999, 1, -1, 0.75, 0.25]

# function calculating value of x_{n+1} using x_{n+1} = (x_n)^2 + c) in Float64 arithmetic
# c: value of c in Float64
# x: current value of x_n in Float64
# returns: value of x_{n+1} in Float64
function nextX(c::Float64, x::Float64)::Float64
    return x^2 + c
end

# function, which is conducting experiment: doing 40 iterations of calculating x_n for all given c's and x_0's; then printing results in table
function experiment()
    results = zeros(Float64, 7, 40)

    for i in 1:7
        x = Float64(x0[i])
        ci = Float64(c[i])
        for j in 1:40
            x = nextX(ci, x)
            results[i, j] = x
        end
    end

    println("values for c = -2")
    println("---------------------------------------------------------------")
    @printf("| %-5s | %-10s | %-10s | %-25s |\n", "n", "x_0 = 1", "x_0 = 2", "x_0 = 1.99999999999999")
    println("---------------------------------------------------------------")
    for i in 1:40
        @printf("| %-5s | %-10s | %-10s | %-25s |\n", i, results[1, i], results[2, i], results[3, i])
    end
    println("---------------------------------------------------------------\n")

    println("values for c = -1")
    println("-------------------------------------------------------------------------------------------")
    @printf("| %-5s | %-10s | %-10s | %-25s | %-25s |\n", "n", "x_0 = 1", "x_0 = -1", "x_0 = 1.90.75", "x_0 = 0.25")
    println("-------------------------------------------------------------------------------------------")
    for i in 1:40
        @printf("| %-5s | %-10s | %-10s | %-25s | %-25s |\n", i, results[4, i], results[5, i], results[6, i], results[7, i])
    end
    println("-------------------------------------------------------------------------------------------\n")

end

experiment()
