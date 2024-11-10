# Kinga Majcher 272354

using LinearAlgebra
using Printf

function hilb(n::Int)
# Function generates the Hilbert matrix  A of size n,
#  A (i, j) = 1 / (i + j - 1)
# Inputs:
#	n: size of matrix A, n>=1
#
#
# Usage: hilb(10)
#
# Pawel Zielinski
    if n < 1
        error("size n should be >= 1")
    end
    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end


function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond(10, 100.0)
#
# Pawel Zielinski
    if n < 2
        error("size n should be > 1")
    end
        if c< 1.0
            error("condition number  c of a matrix  should be >= 1.0")
        end
    (U,S,V)=svd(rand(n,n))
    return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

# function, which solves Ax = b using Gauss's method and method with inverted matrix, calculates relative errors for both methods and prints everyting in table for Hilberts matrices of sizes from 1 to n
# n: maximal size of matrix for which Ax = b is being solved
function solveHilbertsMatrices(n)
    println("Hilbert's matrices")
    println("-----------------------------------------------------------------------------------------------------")
    @printf("| %-5s | %-25s | %-5s | %-25s | %-25s |\n", "Size", "Cond. Num.", "Rank", "Relative Error (Gauss)", "Relative Error (Inverse)")
    println("-----------------------------------------------------------------------------------------------------")
    for i in 1:n
        A = hilb(i)
        x = ones(Float64, i)   
        b = A * x
        
        xGauss = A\b
        xInversion = inv(A)*b

        errorGauss = norm(xGauss - x)/norm(x)
        errorInversion = norm(xInversion - x)/norm(x)

        @printf("| %-5s | %-25s | %-5s | %-25s | %-25s |\n", i, cond(A), rank(A), errorGauss, errorInversion)
    end
    println("-----------------------------------------------------------------------------------------------------\n")
end

# function, which solves Ax = b using Gauss's method and method with inverted matrix, calculates relative errors for both methods and prints everyting in table for random matrices of sizes in n and condition number in c
# n: array of sizes of matrices for which Ax = b is being solved
# c: array of condition numbers of matrices for which Ax = b is being solved
function solveRandomMatrices(n, c)
    println("Random matrices")
    println("-----------------------------------------------------------------------------------------------------")
    @printf("| %-5s | %-25s | %-5s | %-25s | %-25s |\n", "Size", "Cond. Num.", "Rank", "Relative Error (Gauss)", "Relative Error (Inverse)")
    println("-----------------------------------------------------------------------------------------------------")
    for i in n
        for j in c
            A = matcond(i, j)
            x = ones(Float64, i)   
            b = A * x
            
            xGauss = A\b
            xInversion = inv(A)*b

            errorGauss = norm(xGauss - x)/norm(x)
            errorInversion = norm(xInversion - x)/norm(x)

            @printf("| %-5s | %-25s | %-5s | %-25s | %-25s |\n", i, j, rank(A), errorGauss, errorInversion)
        end
    end
    println("-----------------------------------------------------------------------------------------------------\n")
end

solveHilbertsMatrices(13)

global conditionNums = [Float64(1), Float64(10), Float64(10^3), Float64(10^7), Float64(10^12), Float64(10^16)]
global sizes = [5, 10, 20]
solveRandomMatrices(sizes, conditionNums)