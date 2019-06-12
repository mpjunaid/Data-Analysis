#reading the data from xlsx file
library("readxl")
mydata <- read_excel("C:\\Users\\junaid\\Downloads\\Data_Analyst_Assignment_v1.0.xlsx",sheet = 2)

summary(mydata)

#cleaning and making in appropriate fromat
#Here these bellow data is changed NULL becasue when we are talking about sales we dont need information
#about promostion of brand 
#
mydata$`Call Attempts`<- NULL
mydata$`Calls Successfully Completed`<- NULL
mydata$`Emails Sent`<- NULL
mydata$`Emails Opened`<- NULL
mydata$`Faxes Sent`<- NULL

summary(mydata)
#Here the data is transformed into the required data type.in this scenario all categorical values are
#change to factors for easy understanding of data

mydata$Title <- factor(mydata$Title)
mydata$`Specialty Code` <- factor(mydata$`Specialty Code`)
mydata$`Specialty Description` <- factor(mydata$`Specialty Description`)
mydata$State<-factor(mydata$State)
mydata$Region<-factor(mydata$Region)

summary(mydata)


#adding new data columns as required
#here otherbrand will be result of sum of Brand 1 and Brand 2 then substracted from Total brand

mydata$otherbrand <-mydata$`Total Branded Market Sales`-rowSums(mydata[7:8],na.rm=TRUE)

mydata[is.na(mydata)] <- 0
summary(mydata)
#Here we are calculating the next values that is unbranded which is the difference of total sales 
#total branded sales
mydata$unbranded <-(mydata$`Total Market (Branded + Unbranded) Sales`-mydata$`Total Branded Market Sales`)

# visualisation of whole sales data
#each instividual sum of all columns required are calcuated to make the plot
Brand1<-sum(mydata[,7])
Brand2<-sum(mydata[,8])
otherbrands<-sum(mydata[,11])
unbrandeds<-sum(mydata[,12])

#This piepercent is used to calculate the percentages of each category in the pie chart
piepercent<- round(100*x/sum(x), 1)

x<-c(Brand1,Brand2,otherbrands,unbrandeds)
lab<-c("Brand 1","Brand 2","Other Brands","Unbranded")

#ploting the pie chart with the calculated values and shows percentage there
pie(x, labels = piepercent, main = "Sales",col = rainbow(length(x)))
#the legend for the plot is displayed from here
legend("topright", c("Brand 1","Brand 2","Other Brands","Unbranded"), cex = 0.8,
       fill = rainbow(length(x)))
#bar graph is plotted for visualisation
barplot(x,names.arg = labels,ylab="Sales",col="blue",
        main="Total sales chart",border="red")


