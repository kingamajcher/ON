# Kinga Majcher 272354

# function which separates the sign, exponent and mantisa parts of bitstring of given number so they are easier to separates
# number: a variable of type Float64 for which this operation would be done
# returns: separated by spaces string of bytes 
function ieee_with_spaces(number)
    bits = bitstring(number::Float64)
    sign_bit = bits[1]
    exponent_bits = bits[2:12]
    mantissa_bits = bits[13:end]

    return "$sign_bit $exponent_bits $mantissa_bits"
end

# function which calculates delta by searching for the next machine number after left bound of range (left, right) where both left and right are some power of 2 and compares it to expected value of delta calculated from expression delta = 2^(-52 + (exponent - bias))
function find_delta(left, right)
    expected_exp = -52 # base value of exponent for (exponent - bias) = 0
    calculated_delta = Float64(1.0) # base value for calculating delta; 2^exp = 2^0 = 1
    calculated_exp = 0 # base value for exponent; exp = 0

    # calculating next machine number from left bound and calculating how many times exponent were divided 
    while left + calculated_delta/2 > left
        calculated_delta /= 2
        calculated_exp -= 1
    end

    temp = left # variable for temporarily storing value of left bound and used for later computing of expected value of exponent

    # calculating expected value of exponent by calculating the value of power to which 2 is raised when left bound is written in scientific notation of base 2 which is also the value of (exponent - bias) in IEEE 754
    while temp != 1
        if temp >=1
            expected_exp += 1
            temp /= 2
        else
            expected_exp -= 1
            temp *= 2
        end
    end

    delta = Float64(2.0^(expected_exp))

    # printing the bounds ofrange
    println("left:  ", left)
    println("right: ", right, "\n")

    # printing calculated and expected values of delta and exponent, they are expected to be the same
    println("calculated delta exponent: ", calculated_exp)
    println("expected delta exponent:   ", expected_exp, "\n")
    println("calculated delta: ", calculated_delta)
    println("expected delta:   ", delta, "\n")

    num1 = left # value of left bound
    num2 = nextfloat(left) # value of nextfloat(left), used only for comparison whether calculated delta is correct
    num3 = left + delta # calculated value of nextfloat(left)
    num4 = prevfloat(right) # value of prevfloat(right), used only for comparison whether calculated delta is correct
    num5 = left + (2^52 - 1)*delta # calculated value of prevfloat(right); (2^52 - 1) is taken from the fact that there is 52 places in fraction part of double precistion IEEE 754
    num6 = right

    println("left:                         ", ieee_with_spaces(num1))
    println("nextfloat left:               ", ieee_with_spaces(num2))
    println("calculated nextfloat left:    ", ieee_with_spaces(num3))
    println("prevfloat right:              ", ieee_with_spaces(num4))
    println("calculated prevfloat right:   ", ieee_with_spaces(num5))
    println("right:                        ", ieee_with_spaces(num6))

end

find_delta(Float64(2.0), Float64(4.0))