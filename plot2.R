source("load-data.R")
plotFile = "plot2.png"

X11()

# build a datetime
data$datetime = as.POSIXct(strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %T"))
# sort by datetime
data = data[order(data$datetime), ]

plot(
    data$datetime,
    data$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowats)"
)

dev.copy(png, filename = plotFile)
dev.off()