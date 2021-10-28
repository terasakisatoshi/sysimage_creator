jupytext = Sys.which("jupytext")

if isnothing(jupytext)
    jupytext = normpath(Conda.SCRIPTDIR, "jupytext") # e.g. ~/.julia/conda/3/bin/jupytext
end

@time run(`$jupytext --to ipynb --execute testout_naive.jl`)
@time run(`$jupytext --to ipynb --execute testout_sys.jl`)