# Kinga Majcher 272354

# function which calculates value of sqrt(x^2 + 1) - 1 for given x
# x: variable of type Float64 for which value of expression above would be calculated
# returns: value of expression for x
function f(x::Float64)
    return sqrt(x^2 + 1) - 1
end

# function which calculates value of (x^2)/(sqrt(x^2 + 1) + 1) for given x
# x: variable of type Float64 for which value of expression above would be calculated
# returns: value of expression for x
function g(x::Float64)
    return (x^2)/(sqrt(x^2 + 1) + 1)
end

for i in 1:200
    x = Float64(8^Float64(-i))
    println("x = 8^-", i, ",\tf(x) = ", f(x), ",\t\tg(x) = ", g(x))
end