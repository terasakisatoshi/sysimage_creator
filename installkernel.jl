using IJulia
using Libdl

installkernel("Julia-trace", "--project=@.", "--trace-compile=traced_nb.jl")
sysimage = joinpath(@__DIR__, "sys" * "." * Libdl.dlext)
installkernel("Julia-sys", "--project=@.", "--sysimage=$(sysimage)")