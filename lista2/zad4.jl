# Kinga Majcher 272354
using Polynomials, Printf

# polynomial coefficients in form a_n, ..., a_0
global p = [1, -210.0, 20615.0, -1256850.0, 53327946.0, -1672280820.0, 40171771630.0, -756111184500.0, 11310276995381.0, -135585182899530.0, 1307535010540395.0, -10142299865511450.0, 63030812099294896.0, -311333643161390640.0, 1206647803780373360.0, -3599979517947607200.0, 8037811822645051776.0, -12870931245150988800.0, 13803759753640704000.0, -8752948036761600000.0, 2432902008176640000.0]

# polynomial coefficients in form a_n, ..., a_0 with changed a_19
global p_changed = [1, (-210.0-(2^(-23))), 20615.0, -1256850.0, 53327946.0, -1672280820.0, 40171771630.0, -756111184500.0, 11310276995381.0, -135585182899530.0, 1307535010540395.0, -10142299865511450.0, 63030812099294896.0, -311333643161390640.0, 1206647803780373360.0, -3599979517947607200.0, 8037811822645051776.0, -12870931245150988800.0, 13803759753640704000.0, -8752948036761600000.0, 2432902008176640000.0]

# polynomial coefficients in form a_0, ..., a_n as Polynomial constructor requies such form
global coefficients = p[end:-1:1]

# polynomial coefficients with changed a_19 in form a_0, ..., a_n as Polynomial constructor requies such form
global coefficients_changed = p_changed[end:-1:1]

# exact roots of polynomial
global exactRoots = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

# function calculating roots of a polynomial
# coefficients: coefficients of polynomial for which roots would be calculated in form a_0, ..., a_n
# returns: array of calculated roots of given polynomial
function calculateRoots(coefficients)
    polynomial = Polynomial(coefficients)

    return roots(polynomial)
end

# function calculating value of polynomial in general form for given x
# coefficients: coefficients of polynomial in form a_0, ..., a_n
# x: value for which value of polynomial would be calculated
# returns: value of polynomial
function calculateValueGeneralForm(coefficients, x)
    polynomial = Polynomial(coefficients)

    return polynomial(x)
end

# function calculating value of polynomial in general form for given x
# roots: exact roots of polynomial
# x: value for which value of polynomial would be calculated
# returns: value of polynomial
function calculateValueFactoredForm(roots, x)
    polynomial = fromroots(roots)
    
    return polynomial(x)
end

z = calculateRoots(coefficients)
println("--------------------------------------------------------------------------------------------------------------------")
@printf("| %-5s | %-20s | %-25s | %-25s | %-25s |\n", "Size", "z_k", "|z_k - k|", "|P(z_k)|", "|p(z_k)|")
println("--------------------------------------------------------------------------------------------------------------------")

for k in 1:min(20, length(z))
    @printf("| %-5s | %-20s | %-25s | %-25s | %-25s |\n", k, z[k], abs(z[k] - k), abs(calculateValueGeneralForm(coefficients, z[k])), abs(calculateValueFactoredForm(exactRoots, z[k])))
end

println("--------------------------------------------------------------------------------------------------------------------")


z_changed = calculateRoots(coefficients_changed)
println("-------------------------------------------------------------------------------------")
@printf("| %-5s | %-45s | %-25s |\n", "Size", "z_k", "|P(z_k)|")
println("-------------------------------------------------------------------------------------")

for k in 1:min(20, length(z_changed))
    @printf("| %-5s | %-45s | %-25s |\n", k, z_changed[k], abs(calculateValueGeneralForm(coefficients_changed, z_changed[k])))
end

println("-------------------------------------------------------------------------------------")
