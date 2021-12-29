using Conda

jupytext = Sys.which("jupytext")

if isnothing(jupytext)
    jupytext = normpath(Conda.SCRIPTDIR, "jupytext") # e.g. ~/.julia/conda/3/bin/jupytext
end

major = VERSION.major
minor = VERSION.minor
run(`$(jupytext) --execute --to ipynb --set-kernel julia-trace-$(major).$(minor) nb.jl`)
