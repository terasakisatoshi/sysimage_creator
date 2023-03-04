using Test
using PyCall: pyimport_conda
using Conda

@testset "benchmark" begin
    jupytext = Sys.which("jupytext")
    major = VERSION.major
    minor = VERSION.minor

    if isnothing(jupytext)
        pyimport_conda("jupytext", "jupytext", "conda-forge")
        ext = ifelse(Sys.iswindows(), ".exe", "")
        jupytext = normpath(Conda.SCRIPTDIR, "jupytext$(ext)") # e.g. ~/.julia/conda/3/bin/jupytext
    end

    # Warm up Julia (to install Downloading artifact: MKL).
    @elapsed run(
        `$jupytext --execute --to ipynb --set-kernel julia-$(major).$(minor) test/testout_naive.jl`,
    )

    t_naive = @elapsed run(
        `$jupytext --execute --to ipynb --set-kernel julia-$(major).$(minor) test/testout_naive.jl`,
    )
    t_sys = @elapsed run(
        `$jupytext --execute --to ipynb --set-kernel julia-sys-$(major).$(minor) test/testout_sys.jl`,
    )
    @show t_naive t_sys
    r = @test t_naive > t_sys
    if r.value
        @info "We were able to run the sample code $(t_naive/t_sys) times faster using our customized sysimage than using the default sysimage"
    end
end
