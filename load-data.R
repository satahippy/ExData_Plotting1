library(data.table)

if (!dir.exists('data')) {
    dir.create('data')
}

src = 'data/data.zip'
if (!file.exists(src)) {
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', src)
    unzip(src, exdir = 'data')
}

file = 'data/household_power_consumption.txt'
data = fread(
    file,
    sep = ";",
    na.strings = "?"
)

data = data[data$Date == '1/2/2007' | data$Date == '2/2/2007', ]
