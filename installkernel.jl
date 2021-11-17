using IJulia
using Libdl

installkernel("Julia-trace", "--project=@.", "--trace-compile=traced_nb.jl")

sysimage = joinpath(@__DIR__, "sys" * "." * Libdl.dlext)

installkernel(
    "Julia-sys",
    "--project=@.", "--sysimage=$(sysimage)"
)

nthreads = Sys.CPU_THREADS

installkernel(
    "julia-sys-$(nthreads)-threads",
    "--project=@.", "--sysimage=$(sysimage)",
    env=Dict(
        "JULIA_NUM_THREADS"=>"$(nthreads)",
    ),
)
