# -*- coding: utf-8 -*-
# ---
# jupyter:
#   jupytext:
#     formats: ipynb,jl:light
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.13.4
#   kernelspec:
#     display_name: Julia-trace 1.7.1
#     language: julia
#     name: julia-trace-1.7
# ---

# +
using Distributions

using StatsPlots
using DataFrames
# -

1 + 1

plot(sin)
plot!(cos)

# +
x = []
y = []

anim = @animate for θ in -π:0.1:π
    push!(x, cos(θ))
    push!(y, sin(θ))
    plot(x, y, xlim=[-1, 1], ylim=[-1, 1], aspect_ratio=:equal)
end

gif(anim)
# -

mat = DataFrame(rand(10, 10), :auto)
@df mat scatter(:x1, :x2)
