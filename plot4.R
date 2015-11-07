plotFile = "plot4.png"

# load data
source("load-data.R")
# build a datetime
data$datetime = as.POSIXct(strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %T"))
# sort by datetime
data = data[order(data$datetime), ]

# define plot functions
plot1 = function(data) {
    plot(
        data$datetime,
        data$Global_active_power,
        type = "l",
        xlab = "",
        ylab = "Global Active Power"
    )
}

plot2 = function(data) {
    plot(
        data$datetime,
        data$Voltage,
        type = "l",
        xlab = "datetime",
        ylab = "Voltage"
    )
}

plot3 = function(data) {
    cols = data.frame(row.names = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    cols$name = rownames(cols)
    cols$color = c("black", "red", "blue")
    
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
    
    for(col in rownames(cols)){
        col = cols[col,]
        
        points(
            data$datetime,
            data[[col$name]],
            type = "l",
            col = col$color
        )
    }
    
    legend("topright", legend = cols$name, col = cols$color, lty = 1, cex = 0.8)
}

plot4 = function(data) {
    plot(
        data$datetime,
        data$Global_reactive_power,
        type = "l",
        xlab = "datetime",
        ylab = "Global_reactive_power"
    )
}

X11()

par(mfrow = c(2,2))

plot1(data)
plot2(data)
plot3(data)
plot4(data)

dev.copy(png, filename = plotFile)
dev.off()