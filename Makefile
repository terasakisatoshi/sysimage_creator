.PHONY: all instantiate trace build test clean

all: instantiate build

instantiate: Project.toml
	-rm -f Manifest.toml
	julia --project=@. -e 'using Pkg; Pkg.instantiate()'

traced_runtests.jl traced_nb.jl: tracecompile.jl nb.jl
	julia --project=@. --trace-compile=traced_runtests.jl tracecompile.jl
	julia --project=@. installkernel.jl
	julia --project=@. executenb.jl
	julia --project=@. removekernel.jl

build: traced_runtests.jl traced_nb.jl
	julia --project=@. build.jl

test:
	julia --project=@. benchmark.jl

clean:
	-rm -f tmp*
	julia -e 'rm(joinpath(pwd(), "v$$(VERSION.major).$$(VERSION.minor)"), recursive=true, force=true)'
	-rm -f traced_nb.jl traced_runtests.jl
	-rm -f *.ipynb
	-rm -f Manifest.toml
	-rm -rf .ipynb_checkpoints
