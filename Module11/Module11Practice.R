#####
# Module11Practice.R
# Temporal Data
# Representation and graphic display of data over a specific time
#####
library(tidyverse)
# Three important parts to Temporal Data Visualization:
# 1. Time-Series Object: ts, mts, zoo, xts, data.frame*, Tbl*
# 2. Graph Function: 
#   Base R - as.Date(), as.POSIXct(), Sys.Date(), date()
#     modifiers with %
#     dates = c("02/27/92","03/21/92")
#     as.Date(dates,"%m/%d/%y")
#     >"1992-02-27" "1992-03-21"
#   Other packages: 
#     hms - hms::as_hms()
#     lubridate - lubridate::year(),month(),mday(),hour(),minute(),second()
#     ggplot2 - ggplot2::scale_x date()
# 3. Date Styles: 2023-06-01, 2001-01-01 12:00:00 EST, 12:34:56

###ts() object
sstoi.pa <- read.table("sstoi_pa.txt", header=T)
mo.sstoi <- length(sstoi.pa$YR) - 11
yr.sstoi <- mo.sstoi/12
sstoi.pa34 <- ts(sstoi.pa[,3], start = c(1950,1), end = c(1996,12), frequency = 12)
class(sstoi.pa34)

