using IJulia
using Libdl

# This kernel will be removed via removekernel.jl
installkernel("Julia-trace", "--project=@.", "--trace-compile=traced_nb.jl")

major = VERSION.major
minor = VERSION.minor

sysimage_path = joinpath(@__DIR__, "v$(major).$(minor)", "sys" * "." * Libdl.dlext)
mkpath(dirname(sysimage_path))

installkernel(
    "Julia-sys",
    "--project=@.", "--sysimage=$(sysimage_path)"
)

nthreads = Sys.CPU_THREADS

installkernel(
    "julia-sys-$(nthreads)-threads",
    "--project=@.", "--sysimage=$(sysimage_path)",
    env=Dict(
        "JULIA_NUM_THREADS"=>"$(nthreads)",
    ),
)
