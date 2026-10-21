require(zoo)

# Choose Your fund from webpage
# browseURL("https://stooq.pl/t/?i=591")

# Enter the name of your fund or asset
#fundname    <- "3360.n"            # This is example, this line needs to be adjusted

# download data to working directory (comment below lines after downloading data)
#filename    <- paste0("https://stooq.pl/q/d/?s=",fundname)
#browseURL(filename)                 

# 1. Go to the bottom of the webpage 
# 2. Download csv file (right-click on "Pobierz dane w pliku csv..." and save it).
# 3. Copy the file to the working directory
# 4. Provide the name of the file in line below (e.g. 1017_n_d.csv)

csvname    <- "C:/Users/nansh/OneDrive - University of Otago/BCOM/EXCHANGE/Financial_Risk_In_R/Wholesale_price_trends_20261022033938.csv"       # ADJUST THE LINE WITH THE NAME OF YOUR FILE

# Now we can download data and transform it to zoo series, which we use in analyses
x           <- read.csv2(file=csvname, head=TRUE, sep=",", dec=".")
y           <- x[,c(1,5)]
colnames(y) <- c("Dates","Price")
P           <- zoo(y$Price, order.by = as.Date(y$Dates, format = "%d/%m/%Y"))
r           <- diff(log(P))

######################################################################################################
#  A check if there is at least 1250 observations and there is no observation gap longer that 6 days #
######################################################################################################
Ngap         <- max(as.numeric(diff(tail(index(P),1250))))

if(Ngap>6){ 
  print(paste0("Observation gap is longer than 6 days and amounts to ", Ngap))
  print(paste0("Consider changing the fund"))
}

if(length(P)<1250){
  print(paste0("The number of obswervations is below 1250 and amounts to ", length(P)))
  print(paste0("Consider changing the fund"))
}
rm(list=c("Ngap","x","y"))

