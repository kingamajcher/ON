# Kinga Majcher 272354

# function calculating maximum machine number (MAX)
# T: type for which MAX is calculated
# returns: calculated MAX for given type
function calculate_machine_max(T)
    max = T(1.0)
    temp = T(1.0) # temporary variable used for calculating biggest number before 1.0

    while max - temp < T(1.0)
        temp /= 2
    end

    max = max - 2*temp

    while !isinf(2*max)
        max *= 2
    end

    return max
end

println("Calculating max machine number:")
println("Calculated MAX for Float16: ", calculate_machine_max(Float16), " (build in value: ", floatmax(Float16), ")")
println("Calculated MAX for Float32: ", calculate_machine_max(Float32), " (build in value: ", floatmax(Float32), ")")
println("Calculated MAX for Float64: ", calculate_machine_max(Float64), " (build in value: ", floatmax(Float64), ")")