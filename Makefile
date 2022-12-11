.PHONY: all instantiate trace build test clean

OS:=$(shell uname -s)

# https://github.com/julia-actions/julia-runtest
ifeq ($(CI) $(OS),true Linux)
	# run `apt-get install -y xvfb xauth` in advance
	JULIA_PREFIX=xvfb-run
endif

JULIA_COMMAND ?= $(JULIA_PREFIX) julia --project=@.

all: instantiate build

instantiate: Project.toml
	-rm -f Manifest.toml LocalPreferences.toml
	-rm -rf .CondaPkg
	$(JULIA_COMMAND) -e 'using Pkg; Pkg.instantiate()'

traced_runtests.jl traced_nb.jl: tracecompile.jl nb.jl
	$(JULIA_COMMAND) --trace-compile=traced_runtests.jl tracecompile.jl
	$(JULIA_COMMAND) installkernel.jl
	$(JULIA_COMMAND) executenb.jl
	$(JULIA_COMMAND) removekernel.jl

build: traced_runtests.jl traced_nb.jl
	$(JULIA_COMMAND) build.jl

test:
	$(JULIA_COMMAND) benchmark.jl

clean:
	-rm -f tmp*
	$(JULIA_COMMAND) -e 'rm(joinpath(pwd(), "v$$(VERSION.major).$$(VERSION.minor)"), recursive=true, force=true)'
	-rm -f traced_nb.jl traced_runtests.jl
	-rm -f *.ipynb
	-rm -f Manifest.toml
	-rm -rf .ipynb_checkpoints
