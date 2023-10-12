function virial_interp(r, θ)
    a = aa(θ)
    b = b_0(θ)
    c = c_0(θ)
    d = d_0(θ)
    e = e_0(θ)
    term1 = -(a + b * sqrt(r) + c * r) / (r * (1 + d * sqrt(r) + e * r))
    term2 = ((a * d - b) * sqrt(r) / 2 + (a * e - c) * r + (b * e - c * d) * r^(3 / 2) / 2) / (r * (1 + d * sqrt(r) + e * r)^2)
    return term1 + term2
end

function v2_eff(virial::Function, r, θ)
    t = T(r, θ)
    nn = n(r)
    return (virial(r, θ) - (-sqrt(π / t)) * sqrt(nn) - (-π / 2t^2) * (nn * log(4π * nn / t^2))) / nn
end

function v2(temp)
    term1 = 0.5 - sqrt(π) * (1 + log(2)) / (2 * sqrt(temp)) + (0.57721 / 2 + log(3) - 1 / 3 + π^2 / 24) / temp
    term2 = 0.0
    for m = 4:60
        term2 += -sqrt(π) * (m / (2^m * gamma(m / 2 + 1))) * (-1 / sqrt(temp))^(m - 1) * (2 * zeta(m - 2) - (1 - 4 / 2^m) * zeta(m - 1))
    end
    return -π * (term1 + term2) / temp
end

function v3(temp)
    return -3 * π^(3 / 2) / (2 * temp^(7 / 2))
end

function v1(temp)
    return -π / (2temp^2)
end

function v0(temp)
    return -sqrt(π / temp)
end

function v3_eff(virial, r, θ)
    temp = T(r, θ)
    nn = n(r)
    return (virial(r, θ) - v0(temp) * sqrt(nn) - v1(temp) * nn * log(4π * nn / temp^2) - v2(temp) * nn) / (nn^(3 / 2) * log(4π * nn / temp^2))
end

function v3_eff(virial, r, θ, v_2)
    temp = T(r, θ)
    nn = n(r)
    return (virial(r, θ) - v0(temp) * sqrt(nn) - v1(temp) * nn * log(4π * nn / temp^2) - v_2 * nn) / (nn^(3 / 2) * log(4π * nn / temp^2))
end

function v4_eff(virial, r, θ)
    temp = T(r, θ)
    nn = n(r)
    return (virial(r, θ) - v0(temp) * sqrt(nn) - v1(temp) * nn * log(4π * nn / temp^2) - v2(temp) * nn - v3(temp) * nn^(3 / 2) * log(4π * nn / temp^2)) / nn^(3 / 2)
end

export virial_interp, v2_eff, v4_eff, v3_eff
