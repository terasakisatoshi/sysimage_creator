jupytext = Sys.which("jupytext")

if isnothing(jupytext)
    jupytext = normpath(Conda.SCRIPTDIR, "jupytext") # e.g. ~/.julia/conda/3/bin/jupytext
end

run(`$jupytext --to ipynb --execute nb.jl`)