using StatsPlots
using Plots
ENV["CI"] = true
try include(joinpath(pkgdir(Plots), "test", "runtests.jl")) catch end
include(joinpath(pkgdir(StatsPlots), "test", "runtests.jl"))
ENV["CI"] = false
