using PackageCompiler
using Libdl

major = VERSION.major
minor = VERSION.minor

sysimage_path = joinpath(@__DIR__, "v$(major).$(minor)", "sys" * "." * Libdl.dlext)

create_sysimage(
    [:StatsPlots, :Plots, :DataFrames, :Revise],
    precompile_statements_file=[
        "traced_runtests.jl",
        "traced_nb.jl",
    ],
    include_transitive_dependencies = false,
    sysimage_path=sysimage_path,
    cpu_target=PackageCompiler.default_app_cpu_target(),
)

@info "Done!"
