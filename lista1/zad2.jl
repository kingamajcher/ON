# Kinga Majcher 272354

# function calculating macheps using Kahan's method - caluclating value of expression 3 * ((4/3) - 1) - 1
# T: type for which machine epsilon is calculated
# returns: value of macheps calculated using Kahan's method
function calculate_expression_value(T)
    one = T(1.0)
    three = T(3.0)
    four = T(4.0)

    value = three*((four/three) - one) - one

    return value
end

println("Calculated epsilon for Float16: ", calculate_expression_value(Float16), " (build in value: ", eps(Float16), ")")
println("Calculated epsilon for Float32: ", calculate_expression_value(Float32), " (build in value: ", eps(Float32), ")")
println("Calculated epsilon for Float64: ", calculate_expression_value(Float64), " (build in value: ", eps(Float64), ")")