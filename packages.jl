# Julia has thousands of registered packages, making packages a large part of the Julia ecosystem. 
# We can call into Python and R using PyCall or Rcall
# To use packages we have to add them first
using Pkg
Pkg.add("Example")
Pkg.add("Colors")

using Colors
palette = distinguishable_colors(100)

rand(palette, 3, 3)