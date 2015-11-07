source("load-data.R")
plotFile = "plot3.png"

X11()

# build a datetime
data$datetime = as.POSIXct(strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %T"))
# sort by datetime
data = data[order(data$datetime), ]

# define meterings
cols = data.frame(row.names = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
cols$name = rownames(cols)
cols$color = c("black", "red", "blue")

# draw basic plot
plot(
    data$datetime,
    data[[rownames(cols)[1]]],
    type = "l",
    xlab = "",
    ylab = "Energy sub metering",
    ylim = range(
        min(data[, rownames(cols), with = F]),
        max(data[, rownames(cols), with = F])
    )
)

# draw all plots
for(col in rownames(cols)){
    col = cols[col,]
    
    points(
        data$datetime,
        data[[col$name]],
        type = "l",
        col = col$color
    )
}

# draw legend
legend("topright", legend = cols$name, col = cols$color, lty = 1, cex = 0.8)

dev.copy(png, filename = plotFile)
dev.off()