using StatsPlots
using Plots
ENV["CI"] = true

if Sys.islinux()
    ENV["GKSwstype"] = "100"
end

try
	include(joinpath(pkgdir(Plots), "test", "runtests.jl"))
catch e
	@warn "runtests.jl for Plots failed with $(e)"
end
include(joinpath(pkgdir(StatsPlots), "test", "runtests.jl"))
ENV["CI"] = false
