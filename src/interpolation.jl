# Contains an improved interpolation formula which takes low density exact formula and high density pade approximant and interpolates between them.

function interpolation(func_low::Function, func_high::Function, sigmoid::Function, point::Number)
    return x -> func_low(x) * (1 - sigmoid(x, point)) + func_high(x) * sigmoid(x, point)
end

function sigmoid(x, point)
    return exp(-x^2 / point^2)
end

export sigmoid, interpolation