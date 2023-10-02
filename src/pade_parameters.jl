Base.@kwdef struct ParameterA
    a00 = 0.610887
    a0 = 0.75
    a1 = 3.04363
    a2 = -0.09227
    a3 = 1.7035
    a4 = 8.31051
    a5 = 5.1105
end

## For spin unpolarised case
Base.@kwdef struct ParameterB_0
    b1 = 0.3436902
    b2 = 7.82159531356
    b3 = 0.300483986662
    b4 = 15.8443467125
    b5 = b3*sqrt(1.5)*(4/9π)^(-1/3)
end

Base.@kwdef struct ParameterC_0
    c1 = 0.8759442
    c2 = -0.230130843551
end

Base.@kwdef struct ParameterD_0
    d1 = 0.72700876
    d2 = 2.38264734144
    d3 = 0.30221237251
    d4 = 4.39347718395
    d5 = 0.729951339845
end

Base.@kwdef struct ParameterE_0
    e1 = 0.25388214
    e2 = 0.815795138599
    e3 = 0.0646844410481
    e4 = 15.0984620477
    e5 = 0.230761357474
end

function aa(θ)
    A = ParameterA()
    return A.a00*tanh(1/θ)*(A.a0 + A.a1*θ^2 + A.a2*θ^3 + A.a3*θ^4)/(1 + A.a4*θ^2 + A.a5*θ^4)
end

function b_0(θ)
    B = ParameterB_0()
    return tanh(1/sqrt(θ))*(B.b1 + B.b2*θ^2 + B.b3*θ^4)/(1 + B.b4*θ^2 + B.b5*θ^4)
end

function c_0(θ)
    C = ParameterC_0()
    return (C.c1 + C.c2*exp(-1/θ))*e_0(θ)
end

function d_0(θ)
    D = ParameterD_0()
    return tanh(1/sqrt(θ))*(D.d1 + D.d2*θ^2 + D.d3*θ^4)/(1 + D.d4*θ^2 + D.d5*θ^4)
end

function e_0(θ)
    E = ParameterE_0()
    return tanh(1/θ)*(E.e1 + E.e2*θ^2 + E.e3*θ^4)/(1 + E.e4*θ^2 + E.e5*θ^4)
end
