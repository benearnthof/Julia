# Benchmarking
# the @time macro yields noisy results so it's not the best choice for Benchmarking
# the BenchmarkTools.jl package has all we need to make benchmarking easy and accurate

# Pkg.add("BenchmarkTools")
using Pkg
using BenchmarkTools
# Pkg.add("Libdl")

using Libdl
C_code = """
#include <stddef.h>
double c_sum(size_t n, double *X) {
    double s = 0.0;
    for (size_t i = 0; i < n; ++i) {
        s += X[i];
    }
    return s;
}
"""

const Clib = tempname() # creates a temporary file 

# compile to a shared library by piping C_code to gcc
# works only if gcc is installed 

open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib * "."  * Libdl.dlext) -`, "w") do f
    print(f, C_code)
end

# define a julia function that calls the c function

function c_sum(X::Array{Float64})
    ccall(("c_sum", Clib), Float64, (Csize_t, Ptr{Float64}), length(X), X)
end

a = rand(10^7)

@time(sum(a))
@time sum(a)

c_sum(a)

sum_bench = @benchmark sum($a)

d = Dict()
d["Base"] = minimum(sum_bench.times)
d

using Plots
gr()

using Statistics
t = sum_bench.times /1e6
m, sigma = minimum(t), std(t)

histogram(t, bins = 500, 
    xlim = (m - 0.01, m + sigma),
    xlabel = "milliseconds", ylabel = "count", label = "")

# skipping c with fast math

# pythons built in sum function
Pkg.add("PyCall")
using PyCall

pysum = pybuiltin("sum")

py_list_bench = @benchmark $pysum($a)
d["py_sum"] = minimum(py_list_bench.times) / 1e6

# numpy
Pkg.add("Conda")
using Conda

numpy_sum = pyimport("numpy")["sum"]

py_numpy_bench = @benchmark $numpy_sum($a)
d["py_numpy"] = minimum(py_numpy_bench.times) / 1e6

