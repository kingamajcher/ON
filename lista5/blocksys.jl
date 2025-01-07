# Kinga Majcher 272354

module blocksys

export gaussElimination!, gaussEliminationWithPartialPivoting!, generateLU!, generateLUWithPartialPivoting!, solveFromLU!, solveFromLUWithPartialPivoting!, solveUsingLU!, solveUsingLUWithPartialPivoting!

using ..MyBlockMatrix
using ..Utility


"""
function for calculating the solution for set of equations using Gauss elimination without pivoting
    Input:
        A: BlockMatrix
        B: vector of right side od set of equations
    Output:
        x: vector of solutions for set of equations
"""
function gaussElimination!(A::BlockMatrix, b::Vector{Float64})
    n = length(b)               
    x = zeros(Float64, n)

    for k in 1:n-1
        try
            inv = 1 / A[k, k] 
            for i in k+1:getLastRow(A, k)
                if A[i, k] != 0
                    l = A[i, k] * inv 
                    for j in k+1:getLastColumn(A, k)
                        A[i, j] -= l * A[k, j]
                    end
                    b[i] -= l * b[k]
                end
            end
        catch err
            error("Zero value on the diagonal of A at index ($k, $k)")
        end
    end

    x[n] = b[n] / A[n, n]
    for i in n-1 : -1 : 1
        x[i] = b[i]
        for j in i+1 : getLastColumn(A, i)
            x[i] -= A[i, j] * x[j]
        end
        x[i] /= A[i, i]
    end

    return x
end


"""
function for calculating the solution for set of equations using Gauss elimination with partial pivoting
    Input:
        A: BlockMatrix
        B: vector of right side od set of equations
    Output:
        x: vector of solutions for set of equations
"""
function gaussEliminationWithPartialPivoting!(A::BlockMatrix, b::Vector{Float64})
    n = length(b)               
    x = zeros(Float64, n)
    p = [1:n;]

    for k in 1 : n-1
        m = k
        for i in k+1:getLastRow(A, k)
            if abs(A[p[i], k]) > abs(A[p[m], k])
                m = i
            end
        end
        
        p[k], p[m] = p[m], p[k]
        inv = 1 / A[p[k], k]
        for i in k+1 : getLastRow(A, k)
            l = A[p[i], k] * inv 
            A[p[i], k] = 0.0
            for j in k+1 : getLastColumn(A, k + A.l)
                A[p[i], j] -= l * A[p[k], j]
            end
            b[p[i]] -= l * b[p[k]]
        end
    end

    x = zeros(n)
    x[n] = b[p[n]] / A[p[n], n]
    for i in n-1 : -1 : 1
        x[i] = b[p[i]]
        for j in i+1 : getLastColumn(A, i + A.l)
            x[i] -= A[p[i], j] * x[j]
        end
        x[i] /= A[p[i], i]
    end
    return x
end


"""
function for decompositing BlockMatrix into LU without pivoting
    Input:
        A: BlockMatrix
"""
function generateLU!(A::BlockMatrix)    
    n = A.n

    for k in 1 : n-1
        try
            inv = 1 / A[k, k] 
            for i in k+1 : getLastRow(A, k)
                l = A[i, k] * inv
                A[i, k] = l

                for j in k+1 : getLastColumn(A, k)
                    A[i, j] -= l * A[k, j]
                end
            end 
        catch err
            error("Zero value on the diagonal of A at index ($k, $k)")

        end            
    end
end


"""
function for decompositing BlockMatrix into LU with partial pivoting
    Input:
        A: BlockMatrix
    Output:
        p: vector of permutations
"""
function generateLUWithPartialPivoting!(A::BlockMatrix)   
    n = A.n
    p = [1:n;]
    for k in 1 : n-1
        m = k
        for i in k+1:getLastRow(A, k)
            if abs(A[p[i], k]) > abs(A[p[m], k])
                m = i
            end
        end
        p[k], p[m] = p[m], p[k]
        inv = 1 / A[p[k], k]
        for i in k+1 : getLastRow(A, k)
            l = A[p[i], k] * inv
            A[p[i], k] = l
            for j in k+1 : getLastColumn(A, k + A.l)
                A[p[i], j] -= l * A[p[k], j]
            end
        end
    end
    return p
end


"""
function for calculating the solution for set of equations using LU decomposition without pivoting
    Input:
        LU: BlockMatrix decomposited into LU
        B: vector of right side od set of equations
    Output:
        x: vector of solutions for set of equations
"""
function solveFromLU!(LU::BlockMatrix, b::Vector{Float64})
    n = LU.n

    for k in 1 : n - 1
        for i in k + 1 : getLastRow(LU, k)
            b[i] -= LU[i, k] * b[k]
        end
    end

    x = zeros(Float64, n)
    x[n] = b[n] / LU[n, n]
    for i in n - 1 : -1 : 1
        x[i] = b[i]
        for j in i+1 : getLastColumn(LU, i)
            x[i] -= LU[i, j] * x[j]
        end
        x[i] /= LU[i, i]
    end
    return x
end


"""
function for calculating the solution for set of equations using LU decomposition with partial pivoting
    Input:
        LU: BlockMatrix decomposited into LU
        P: vector of permutations
        B: vector of right side od set of equations
    Output:
        x: vector of solutions for set of equations
"""
function solveFromLUWithPartialPivoting!(LU::BlockMatrix, P::Vector{Int}, b::Vector{Float64})
    n = LU.n

    for k in 2 : n
        for i in getFirstColumn(LU, P[k]) : k-1
            b[P[k]] -= LU[P[k], i] * b[P[i]]
        end
    end

    x = zeros(Float64, n)
    x[n] = b[P[n]] / LU[P[n], n]
    for i in n-1 : -1 : 1
        x[i] = b[P[i]]
        for j in i+1 : getLastColumn(LU, i + LU.l)
            x[i] -= LU[P[i], j] * x[j]
        end
        x[i] /= LU[P[i], i]
    end
    return x
end


"""
function for calculating the solution for set of equations using LU decomposition without pivoting when given A matrix
    Input:
        A: BlockMatrix
        B: vector of right side od set of equations
    Output:
        x: vector of solutions for set of equations
"""
function solveUsingLU!(A::BlockMatrix, b::Vector{Float64})
    generateLU!(A)
    return solveFromLU!(A, b)
end


"""
function for calculating the solution for set of equations using LU decomposition with partial pivoting when given A matrix
    Input:
        A: BlockMatrix
        P: vector of permutations
        B: vector of right side od set of equations
    Output:
        x: vector of solutions for set of equations
"""
function solveUsingLUWithPartialPivoting!(A::BlockMatrix, b::Vector{Float64})
    P = generateLUWithPartialPivoting!(A)
    return solveFromLUWithPartialPivoting!(A, P, b)
end

end