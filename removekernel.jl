using IJulia: kerneldir

rm(
    joinpath(
        kerneldir(),
        "julia-trace-$(VERSION.major).$(VERSION.minor)",
    ),
    force=true,
    recursive=true,
)
