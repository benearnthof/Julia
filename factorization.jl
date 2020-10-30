using LinearAlgebra
A = rand(3,3)
x = fill(1, (3,))
b = A * x 

# LU factorization
Alu = lu(A)
typeof(Alu)
# PA = LU
Alu.L * Alu.U
Alu.P
A

# Julia can dispatch methods on factorization objects
A\b 
Alu\b 
det(A) == det(Alu)