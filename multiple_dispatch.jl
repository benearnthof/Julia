# Multiple dispatch
# makes software generic and fast
f(x) = x^2
# this function works for multiple different types of arguments
f(10)
# this does not work for arrays though
# we can specify the types of input arguments that are allowed like so:
foo(x::String, y::String) = println(x,y)
foo("wot", "dafak")
foo(x::Integer, y::Integer) = x + y
foo(3,4)
foo("wot", "wot")

# we can add as many different methods to the generic function as we like!
# we can use methods to see how many methods there are for foo
methods(foo)
methods(+)
# 184 different addition methods in julia!

# to see which method is being dispatched when we call a generic function, we can use the @which macro
@which 3.0 + 3.0
@which 3 + 3

foo(x::Number, y::Number) = println("My inputs x and y are both numbers!")
# this method will work on floating point numbers
foo(3.4, 6.8)

# we can also add a fallback, duck-typed method for foo that takes inputs of any type
foo(x, y) = println("x and y are of type any")
v = rand(3)
foo(v, v)