# Kinga Majcher 272354

x = [2.718281828,-3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

# function for calculating scalar product of x and y in order
# T: type in which scalar product is calculated
# returns: calculated sum
function sum_in_order(T)
    sum = T(0.0)
    for i in 1:length(x)
        sum += T(x[i]) * T(y[i])
    end
    return sum
end

# function for calculating scalar product of x and y in reverse order
# T: type in which scalar product is calculated
# returns: calculated sum
function sum_in_reverse_order(T)
    sum = T(0.0)
    for i = length(x):-1:1
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

    products = [T(xi) * T(yi) for (xi, yi) in zip(x, y)]

    positive_products = sort([p for p in products if p >= 0], rev = true)

    negative_products = sort([p for p in products if p < 0])

    for i in 1:length(positive_products)
        positive_sum += positive_products[i] 
    end

    for i in 1:length(negative_products)
        negative_sum += negative_products[i] 
    end

    sum = positive_sum + negative_sum
    return sum
end

# function for calculating scalar product of x and y in order of increasing absolute value of sums, positive sum and negative sum separately
# T: type in which scalar product is calculated
# returns: calculated sum
function sum_in_increasing_order(T)
    positive_sum = T(0.0)
    negative_sum = T(0.0)

    products = [T(xi) * T(yi) for (xi, yi) in zip(x, y)]

    positive_products = sort([p for p in products if p >= 0])
    negative_products = sort([p for p in products if p < 0], rev = true)

    for i in 1:length(positive_products)
        positive_sum += positive_products[i] 
    end

    for i in 1:length(negative_products)
        negative_sum += negative_products[i] 
    end

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