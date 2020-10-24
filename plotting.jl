# Plotting in Julia
# Pkg.add("Plots")
using Plots

x = 1:25
x = x + rand(Float64, (25,1))
y = 1:25 
y = y + rand(Float64, (25, 1))

gr()
plot(x, y, label = "line")
scatter!(x, y, label = "points")
title!("Very gud title yes")
# the bang syntax tells the plot to add another layer to it 
xflip!()
# switches the x axis

# we can create this plot with the unicodeplots backend without changing syntax!
# Pkg.add("PyPlot")
# Pkg.add("UnicodePlots")
unicodeplots() 
pyplot()

plot(x, y, label = "line")
scatter!(x, y, label = "points")
xlabel!("X Label")
ylabel!("Y Label")
title!("Gimme a good title!")
xflip!()

# plots can be saved as variables like in ggplot
