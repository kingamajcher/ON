# Kinga Majcher 272354

module Utility

export loadVectorFromFile, generateB, generateBOnes, saveVectorToFile, saveVectorWithErrorToFile, calculateRelativeError

using ..MyBlockMatrix
using LinearAlgebra

"""
Function for loading vector from file
    Input:
        filepath: path to file from which vector will be loaded
    Output:
        vector loaded from file
"""
function loadVectorFromFile(filepath::String)::Vector{Float64}
    open(filepath, "r") do file
        first_line = readline(file)
        n = parse.(Int, first_line)
        
        V = zeros(Float64, n)

        i = 1
        for line in eachline(file)
            value = parse.(Float64, line)
            V[i] = value
            i += 1
        end

        return V
    end
end


"""
Function for generating vector b, when vector x is given   
    Input:
        M: BlockMatrix
        x: vector 
    Output:
        generated vector
"""
function generateB(M::BlockMatrix, x::Vector{Float64})::Vector{Float64}
    n = M.n
    b = zeros(Float64, n)

    for i in 1:n
        offset, values = M.rows[i]
        if isempty(values)
            continue
        end

        for (j, value) in enumerate(values)
            col = offset + j - 1
            b[i] += value * x[col]
        end
    end

    return b
end


"""
Function for generating vector b, when vector x is (1, ..., 1)
    Input:
        M: BlockMatrix
    Output:
        generated vector
"""
function generateBOnes(M::BlockMatrix)::Vector{Float64}
    n = M.n
    x = ones(Float64, n)
    return generateB(M, x)
end


"""
function for saving vector to file
    Input:
        vector: vector which will be saved to file
        filepath: path in which file will be saved
"""
function saveVectorToFile(vector::Vector{Float64}, filepath::String)
    open(filepath, "w") do file
        for value in vector
            println(file, value)
        end
    end
    println("Vector saved in file: $filepath")
end


"""
function for saving vector to file with error
    Input:
        initialVector: inintial vector
        calculatedVector: vector which will be saved to file
        filepath: path in which file will be saved
"""
function saveVectorWithErrorToFile(initialVector::Vector{Float64}, calculatedVector::Vector{Float64}, filepath::String)
    open(filepath, "w") do file
        error = calculateRelativeError(initialVector, calculatedVector)
        println(file, error)
        for value in calculatedVector
            println(file, value)
        end
    end
    println("Vector saved in file: $filepath")
end


"""
Function for calculating the relative error of two vectors
    Input:
        vector1: vector with expected values
        vector2: vector with calculated values
    Output:
        relative error of two vectors
"""
function calculateRelativeError(vector1::Vector{Float64}, vector2::Vector{Float64})::Float64
    if length(vector1) != length(vector2)
        error("Vectors must have the same length!")
    end

    numerator = norm(vector1 - vector2)

    denominator = norm(vector1)

    if denominator == 0
        error("Norm of exact vector is 0, cannot calculate relative error!")
    end

    return numerator / denominator
end

end