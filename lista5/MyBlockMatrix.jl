# Kinga Majcher 272354

module MyBlockMatrix

export BlockMatrix, loadMatrixFromFile, printMatrix,  getFirstColumn, getLastColumn, getLastRow


"""
Struct BlockMatrix
    n: - size of matrix
    l: size of one block
    rows: vector of vectors of values in matrix
"""
struct BlockMatrix
    n::Int
    l::Int
    rows::Vector{Tuple{Int, Vector{Float64}}}   # rows: offset, values
end


"""
Constructor for BlockMatrix
    Input: 
        n: size of matrix
        l: size of one block
    Output:
        empty BlockMatrix of given sizes
"""
function BlockMatrix(n::Int, l::Int)
    rows = [(0, Float64[]) for _ in 1:n]  # empty rows
    return BlockMatrix(n, l, rows)
end

"""
Getter (M[i, j])
    Input:
        M: BlockMatrix
        i: value of row
        j: value of getLastColumn
    Output:
        value of matrix in [i, j]
"""
function Base.getindex(M::BlockMatrix, i::Int, j::Int)::Float64
    row = M.rows[i]
    offset, values = row

    if isempty(values) || j < offset || j >= offset + length(values)
        return 0.0
    else
        return values[j - offset + 1]
    end
end


"""
Setter (M[i, j]) = value
    Input:
        M: BlockMatrix
        i: value of row
        j: value of getLastColumn
"""
function Base.setindex!(M::BlockMatrix, value::Float64, i::Int, j::Int)
    row = M.rows[i]
    offset, values = row

    if value == 0.0
        # If the value to be inserted is zero, do nothing (we don't store zeros explicitly)
        return
    end

    if isempty(values)
        # If the row is empty, set the offset to j and store the value as the first element
        M.rows[i] = (j, [value])
    else
        # If the row already contains values
        if j < offset
            # If the value is being set before the current offset:
            # Add zeros to fill the gap between the new position and the existing values,
            # update the offset, and insert the value at the new position
            prepend_zeros = offset - j
            values = vcat(zeros(Float64, prepend_zeros), values)
            values[1] = value
            M.rows[i] = (j, values)
        elseif j >= offset + length(values)
            # If the value is being set after the end of the current values:
            # Add zeros to extend the row and then add the new value at the specified position
            append_zeros = j - (offset + length(values)) + 1
            values = vcat(values, zeros(Float64, append_zeros))
            values[end] = value
            M.rows[i] = (offset, values)
        else
            # If the value is being set within the range of existing values:
            # Update the corresponding element in the row
            values[j - offset + 1] = value
            M.rows[i] = (offset, values)
        end
    end
end


"""
Function for loading matrix from file
    Input:
        filepath: path to file from which matrix will be loaded
    Output:
        BlockMatrix loaded from file
"""
function loadMatrixFromFile(filepath::String)::BlockMatrix
    open(filepath, "r") do file
        # Reading first line (sizes n and l)
        first_line = readline(file)
        n, l = parse.(Int, split(first_line))
        
        M = BlockMatrix(n, l)
        
        # Reading the rest of lines and set values in matrix
        for line in eachline(file)
            i, j, value = parse.(Float64, split(line))
            M[Int(i), Int(j)] = value
        end

        return M
    end
end


"""
Function for getting the index of column in which there is first non empty value in given row
    Input:
        M: BlockMatrix
        row: number of row for which the first column is calculated
    Output:
        number of column in which there is first non empty value in given row
"""
function getFirstColumn(M::BlockMatrix, row::Int)
    thisRow = M.rows[row]
    offset, values = thisRow

    if isempty(values)
        return 1
    else
        return offset
    end
end



"""
Function for getting the index of column in which there is last non empty value in given row
    Input:
        M: BlockMatrix
        row: number of row for which the last column is calculated
    Output:
        number of column in which there is last non empty value in given row
"""
function getLastColumn(M::BlockMatrix, row::Int)
    return min(M.n, M.l + row)
end


"""
Function for getting the index of row in which there is last non empty value in given column
    Input:
        M: BlockMatrix
        column: number of column for which the last row is calculated
    Output:
        number of row in which there is last non empty value in given column
"""
function getLastRow(M::BlockMatrix, column::Int)
    if column % M.l == M.l-1
        return min(M.n, (div(column, M.l) + 2) * M.l)
    else
        return min(M.n, (div(column, M.l) + 1) * M.l)
    end
end


"""Function for displaying matrix
    Input:
        M: BlockMatrix
"""
function printMatrix(M::BlockMatrix)
    println("BlockMatrix:")
    for (i, row) in enumerate(M.rows)
        offset, values = row
        println("R $i: O = $offset, V = $values")
    end
end

end
