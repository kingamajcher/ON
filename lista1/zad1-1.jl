# Kinga Majcher 272354

# function calculating machine epsilon (macheps)
# T: type for which machine epsilon is calculated
# returns: calculated machine epsilon for given type
function calculate_machine_epsilon(T)
    epsilon = T(1.0)
    while T(1.0) + epsilon > T(1.0)
        epsilon /= 2
    end
    return epsilon * 2
end

println("Calculating machine epsilon:")
println("Calculated epsilon for Float16: ", calculate_machine_epsilon(Float16), " (build in value: ", eps(Float16), ")")
println("Calculated epsilon for Float32: ", calculate_machine_epsilon(Float32), " (build in value: ", eps(Float32), ")")
println("Calculated epsilon for Float64: ", calculate_machine_epsilon(Float64), " (build in value: ", eps(Float64), ")")
