using Test

@testset "benchmark" begin 
    jupytext = Sys.which("jupytext")

    if isnothing(jupytext)
        jupytext = normpath(Conda.SCRIPTDIR, "jupytext") # e.g. ~/.julia/conda/3/bin/jupytext
    end

    t_naive = @elapsed run(`$jupytext --to ipynb --execute testout_naive.jl`)
    t_sys = @elapsed run(`$jupytext --to ipynb --execute testout_sys.jl`)
    @show t_naive
    @show t_sys
    @test t_naive > t_sys
end