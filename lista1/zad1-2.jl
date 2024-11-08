# Kinga Majcher 272354

# function calculating smallest machine number (eta)
# T: type for which eta is calculated
# returns: calculated eta for given type
function calculate_machine_eta(T)
    eta = T(1.0)
    exp = 0 # exponent of eta (eta is in form of 2^exp)
    while eta / 2 > T(0.0)
        eta /= 2
        exp -= 1
    end
    println("exponent = ",exp)
    return eta
end

println("Calculating machine eta:\n")
println("Calculated eta for Float16: ", calculate_machine_eta(Float16), " (build in value: ", nextfloat(Float16(0.0)), ")\n")
println("Calculated eta for Float32: ", calculate_machine_eta(Float32), " (build in value: ", nextfloat(Float32(0.0)), ")\n")
println("Calculated eta for Float64: ", calculate_machine_eta(Float64), " (build in value: ", nextfloat(Float64(0.0)), ")")
