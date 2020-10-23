# intro to julia notes
# Data structures 
# tuples are ordered collections of items

animals = ("penguins", "cats", "elephants")

# julia indexes start at 1
animals[1]

# named tuples
animals = (bird = "penguins", mammal = "cats", elephant = "elephants")

animals.mammal

# Dictionaries
# for sets of data related to one another we may choose to store that data in a dictionary
# we create dictionaries using the Dict() function
mydictionary = Dict("Hans" => "1337", "Johann" => "420", "Johannes" => "69")
mydictionary["Hans"]

# add new entries to the dictionary like so
mydictionary["Xaver"] = "69420"
mydictionary

# we can delete entries in a dictionary using the popbang function
pop!(mydictionary, "Xaver")
mydictionary

# Arrays
# Arrays are ordered and mutable
people = ["Ted", "Robin", "Barney", "Lily", "Marshall"]
people[4]

# Arrays can be mixed
mixed = ["Kappa", 177]
mixed[1]
mixed[2]
mixed
# replacing elements works like in R
# with the pushbang function we can add another element to the Array
push!(mixed, "wotwotwot")
mixed

# we can also create arrays of arrays and multidimensional arrays
rand(4,3)
rand(2,2,2,2)
rand(1:10,4,3,2)

# assignment in julia is not equal to copying!
somenumbers = rand(1:10, 5,5)
othernumbers = somenumbers
othernumbers[1,1] = 100
othernumbers, somenumbers
# both of them have the entry 100 as the element in position 1,1
# to avoid this we need to make a distinct copy
# deepcopy copies elements of arrays recursively
someothernumberstwo = copy(somenumbers)
someothernumberstwo[1,1] = 17
someothernumberstwo, somenumbers 

# loops and iterables 
n = 0
while n < 10
    n = n + 1
    println(n)
end

i = 1
while i <= length(people)
    friend = people[i]
    println("Hi $friend, it's great to see you!")
    i += 1
end

# for loops
for n in 1:10
    println(n)
end
# pretty nice syntax!

# we can also use iterables instead of defining a range
for friend in people
    println("Hi $friend, it's great to see you!")
end

# what is particularly interesting in julia is the array comprehension to avoid nested loops
m, n = 5, 5
A = fill(0, (m, n))

for i in 1:m
    for j in 1:n
        A[i, j] = i + j
    end
end
A

# we can avoid the nested loop using syntactic sugar!
B = fill(0, (m, n))
for i in 1:m, j in 1:n
    B[i, j] = i + j
end
B

# we can also do it in one line using array comprehension!
C = [i + j for i in 1:m, j in 1:n]
C

# lets wrap this in functions and check the assembly
nested = function(m, n)
    A = fill(0, (m, n))
    for i in 1:m
        for j in 1:n
            A[i, j] = i + j
        end
    end
    return(A)
end

sugar = function(m, n)
    B = fill(0, (m, n))
    for i in 1:m, j in 1:n
        B[i, j] = i + j
    end
    return(B)
end

compr = function(m, n)
    C = [i + j for i in 1:m, j in 1:n]
    return(C)
end

code_native(nested, (Int64, Int64))
code_native(sugar, (Int64, Int64))
code_native(compr, (Int64, Int64))
# as expected, the assembly of the function using array comprehension is a lot shorter!
# todo: benchmark the functions to see if the shorter assembly results in faster code

# we can also create arrays using array comprehension
[x^3 for x in 1:100]


# conditionals in julia
n = 83
if (n % 3 == 0) && (N % 5 == 0)
    println("FizzBuzz")
elseif(n % 3 == 0)
    println("Fizz")
elseif(n % 5 == 0)
    println("Buzz")
else
    println(n)
end

# ternary operators with syntax ?
# a ? b : c
# is equivalent to 
# if a
#   b
# else 
# c

x = 100
y = 10

if x > y
    x
else
    y
end
# is equivalent to
x > y ? x : y

# Functions: 
# Duck-typing, mutating vs. non-mutating functions, higher order functions