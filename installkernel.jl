using IJulia
installkernel("Julia-trace", "--project=@.", "--trace-compile=traced_nb.jl")
installkernel("Julia-sys", "--project=@.", "--sysimage=sys")