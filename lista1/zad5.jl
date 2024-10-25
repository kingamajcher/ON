x = [2.718281828,-3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

# function for calculating scalar product of x and y in order
# T: type in which scalar product is calculated
# returns: calculated sum
function sum_in_order(T)
    sum = T(0.0)
    for i in 1:5
        sum += T(x[i]) * T(y[i])
    end
    return sum
end

# function for calculating scalar product of x and y in reverse order
# T: type in which scalar product is calculated
# returns: calculated sum
function sum_in_reverse_order(T)
    sum = T(0.0)
    for i = 5:-1:1
        sum += T(x[i]) * T(y[i])
    end
    return sum
end

# function for calculating scalar product of x and y in order of decreasing absolute value of sums, positive sum and negative sum separately
# T: type in which scalar product is calculated
# returns: calculated sum
function sum_in_decreasing_order(T)
    positive_sum = T(0.0)
    negative_sum = T(0.0)
    positive_sum += T(x[4]) * T(y[4])
    positive_sum += T(x[1]) * T(y[1])
    positive_sum += T(x[5]) * T(y[5])
    negative_sum += T(x[2]) * T(y[2])
    negative_sum += T(x[3]) * T(y[3])
    sum = positive_sum + negative_sum
    return sum
end

# function for calculating scalar product of x and y in order of increasing absolute value of sums, positive sum and negative sum separately
# T: type in which scalar product is calculated
# returns: calculated sum
function sum_in_increasing_order(T)
    positive_sum = T(0.0)
    negative_sum = T(0.0)
    positive_sum += T(x[5]) * T(y[5])
    positive_sum += T(x[1]) * T(y[1])
    positive_sum += T(x[4]) * T(y[4])
    negative_sum += T(x[3]) * T(y[3])
    negative_sum += T(x[2]) * T(y[2])
    sum = positive_sum + negative_sum
    return sum
end

println("Values for Float32:")
println("In order:\t\t", sum_in_order(Float32))
println("In reversed order:\t", sum_in_reverse_order(Float32))
println("In decreasing order:\t", sum_in_decreasing_order(Float32))
println("In increasing order:\t",sum_in_increasing_order(Float32))

println()

println("Values for Float64:")
println("In order:\t\t", sum_in_order(Float64))
println("In reversed order:\t", sum_in_reverse_order(Float64))
println("In decreasing order:\t", sum_in_decreasing_order(Float64))
println("In increasing order:\t",sum_in_increasing_order(Float64))