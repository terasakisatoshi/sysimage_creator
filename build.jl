using PackageCompiler
using Libdl: dlext

create_sysimage(
    [:StatsPlots, :Plots, :DataFrames], 
    precompile_statements_file=[
        "traced_runtests.jl", 
        "traced_nb.jl"
    ],
    sysimage_path=joinpath(@__DIR__, "sys.$(dlext)"),
    cpu_target = PackageCompiler.default_app_cpu_target()
)

@info "Done!"