# function calculating smallest machine number (eta)
# T: type for which eta is calculated
# returns: calculated eta for given type
function calculate_machine_eta(T)
    eta = T(1.0)
    while eta / 2 > T(0.0)
        eta /= 2
    end
    return eta
end

println("Calculating machine eta:")
println("Calculated eta for Float16: ", calculate_machine_eta(Float16), " (build in value: ", nextfloat(Float16(0.0)), ")")
println("Calculated eta for Float32: ", calculate_machine_eta(Float32), " (build in value: ", nextfloat(Float32(0.0)), ")")
println("Calculated eta for Float64: ", calculate_machine_eta(Float64), " (build in value: ", nextfloat(Float64(0.0)), ")")