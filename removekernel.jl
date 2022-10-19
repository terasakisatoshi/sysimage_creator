using IJulia: kerneldir

kernelname = "julia-trace-$(VERSION.major).$(VERSION.minor)"
@info "removing kernel" kernelname

rm(
    joinpath(
        kerneldir(),
        kernelname,
    ),
    force=true,
    recursive=true,
)
