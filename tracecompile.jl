using StatsPlots
using Plots

include(joinpath(pkgdir(StatsPlots), "test", "runtests.jl"))
try include(joinpath(pkgdir(Plots), "test", "runtests.jl")) catch end
