function virial_interp(r, θ)
    a = aa(θ)
    b = b_0(θ)
    c = c_0(θ)
    d = d_0(θ)
    e = e_0(θ)
    term1 = -(a + b*sqrt(r) + c*r)/(r*(1 + d*sqrt(r) + e*r))
    term2 = ((a*d - b)*sqrt(r)/2 + (a*e - c)*r + (b*e - c*d)*r^(3/2)/2)/(r*(1+ d*sqrt(r) + e*r)^2)
    return term1 + term2
end

function v2_eff(virial::Function,r,θ)
    t = T(r, θ)
    nn = n(r)
    return (virial(r,θ) - (-sqrt(π/t))*sqrt(nn) - (-π/2t^2)*(nn*log(4π*nn/t^2)))/nn
end

function v2(T)
    return nothing
end

export virial_interp, v2_eff
