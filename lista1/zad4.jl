# function calculating smallest number for which x*(1/x) != 1, where 1 < x < 2
# returns: smallest number for which such conditions are met, otherwise -1
function find_x()
    num = Float64(1.0) # variable for which condition x*(1/x) != 1 would be met
    delta = Float64(2.0)^(-52) # delta known to be between numbers from [1, 2]; known from ex3

    while num < Float64(2.0)
        if num * (Float64(1.0)/num) != 1
            return num
        end
        num += delta
    end

    return -1
end

x = find_x()

if x == -1
    println("There is an exact inverse for each number in (1, 2)")
else
    println("The smallest number that does not have an exact inverse in (1, 2) is: ", x)
end