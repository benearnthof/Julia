# basic linear algebra in julia
A = rand(1:4, 3, 3)

# define a vector of ones
x = fill(1.0, (3,))

# Multiplication
b = A*x
# Transposition 
A'
A
transpose(A)
# Transposed Multiplication
A' * A
A'A

# Solving linear systems 
# The problem Ax = b for square matrices is solved by the \ function
A\b
# if we have an overdetermined linear system we can use the \ function to get the least squares solution
Atall = rand(1:4, 4, 3)
x = fill(1.0, (3,))
btall = Atall*x
Atall\btall
# and we get the minimum norm least squares solution if we have a rank deficient least squares problem
v = rand(3)
rankdef = hcat(v,v)
rankdef\b
# if we have an underdetermined solution we also get the minimum norm solution
bshort = rand(2)
Ashort = rand(2,3)
Ashort\bshort

# for any more advanced functionality we use the LinearAlgebra library
# we can compute dot products like so 
v'v
# outer products can be computed like so 
v * v'