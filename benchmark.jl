using Test

@testset "benchmark" begin
    jupytext = Sys.which("jupytext")
    major = VERSION.major
    minor = VERSION.minor

    if isnothing(jupytext)
        jupytext = normpath(Conda.SCRIPTDIR, "jupytext") # e.g. ~/.julia/conda/3/bin/jupytext
    end

    # Warm up Julia (to install Downloading artifact: MKL).
    @elapsed run(
        `$jupytext --execute --to ipynb --set-kernel julia-$(major).$(minor) testout_naive.jl`,
    )

    t_naive = @elapsed run(
        `$jupytext --execute --to ipynb --set-kernel julia-$(major).$(minor) testout_naive.jl`,
    )
    t_sys = @elapsed run(
        `$jupytext --execute --to ipynb --set-kernel julia-sys-$(major).$(minor) testout_sys.jl`,
    )
    @show t_naive
    @show t_sys
    @test t_naive > t_sys
end
