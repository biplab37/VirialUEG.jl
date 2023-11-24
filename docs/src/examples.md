# Examples

### 1. Calculation of ``v_2^{\rm eff}``

Import the package
```julia
using VirialUEG
```
The package provides the function [`virial_interp`](@ref) which calculates the virial term from the interpolation formula.
Using this one can calculate effective virial co-efficients as mentioned in the paper.
For example, for the second virial coefficient one can use,
```julia
v2_eff(virial_interp, r, theta)
```
