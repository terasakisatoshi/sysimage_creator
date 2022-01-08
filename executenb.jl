using Conda

jupytext = Sys.which("jupytext")

if isnothing(jupytext)
    @info "try to use jupytext via Conda.jl"
    jupytext = normpath(Conda.SCRIPTDIR, "jupytext") # e.g. ~/.julia/conda/3/bin/jupytext
    if !isfile(jupytext)
        msg = """
        Unable to find `jupytext` command. Try the following instructions:
        ```
        julia> # You'll find a hint in README.md
        julia> ENV["PYTHON"]=""; ENV["JUPYTER"]=""
        julia> using Pkg; Pkg.add(["PyCall", "IJulia", "Conda"])
        julia> using Conda; Conda.add(["jupyter", "jupytext"], channel="conda-forge")
        ```
        and retry `make` comand or `julia $(basename(@__FILE__))` again.
        """
        error(msg)
    end
end

major = VERSION.major
minor = VERSION.minor
run(`$(jupytext) --execute --to ipynb --set-kernel julia-trace-$(major).$(minor) nb.jl`)
