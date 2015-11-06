source("load-data.R")
plotFile = "plot1.png"

X11()

hist(
    data$Global_active_power,
    main = "Global Active Power",
    col = "#fb0007",
    xlab = "Global Active Power (kilowats)"
)

dev.copy(png, filename = plotFile)
dev.off()