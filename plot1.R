# plot1.R
# 2/5/2015 7:30:00 PM
# first part of script downloads and unzips the data file if necessary

localFile    = "household_power_consumption.txt"
localzipFile = "household_power_consumption.zip"
zipfileURL   = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (! file.exists(localFile)) {
    print("local copy of data file does not exist")
    if (! file.exists(localzipFile)) {
        print("local copy of zipped data file does not exist")
        download.file(zipfileURL, localzipFile, method="curl", extra="--insecure")
    }
    unzip(localzipFile)
}
# second part of script loads the data into a data frame then makes a new data frame with just the rows that we want to plot
# NA is represented by question mark
# using as.Date() means we don't have to wonder if "day" and "month" values are one or two characters

data     <- read.table(localFile, sep=";", header=TRUE, na.strings="?", colClasses=c(rep("character", 2), rep("numeric", 7)))

data.sub <- subset(data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")

png("plot1.png", width=480, height=480)

hist(data.sub$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

dev.off()
