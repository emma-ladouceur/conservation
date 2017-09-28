
#make sure you have all these packages first!
library(sqldf)
library(multcompView)
library(reshape)
install.packages("yarrr")  # Install package from CRAN
library("yarrr") # Load the package

piratepal() #view all pirate color palettes
piratepal(palette = "basel") #view the colors from a specific palette
#make your own palette!
my.pirate.pal<-c("#7F8624FF", "#4D709CFF","#170C2EFF","#52194CFF","#751029FF", "#F2990CFF" )

View(pirates) # We will use the provided dataset pirates
write.csv(pirates, "/Users/emmaladouceur/Desktop/pirates.csv")
# partition the document into two columns and set margins
par(mfrow = c(1, 3), mar=c(5,5,2,1))

# Standard Barplot
pirateplot(beard.length~favorite.pirate,
           data=pirates,
           cex.names = .5,
           main = "Boring Barplot",
           xlab = " ",
           ylab = " ",
           theme = 0, # Start from scratch
           bar.f.o = .7) # Just turn on the bars


# And  I even find them better than a boxplot because it can hide whats 
#happening behind the summarized box and whiskers
boxplot(beard.length~favorite.pirate,
        data=pirates, cex.axis=0.75, mtext("Normal Boxplot", xlab="Favorite Pirate", 
        font=2,side = 3, line = -1.5, cex=.75, outer = TRUE),
        mtext("Favorite Pirate", 
            font=2, side = 3, line = -52.5, cex=.75, outer = TRUE),
                            title(ylab="Beard legnth"))

# A Standard plot with no adjustments
pirateplot(formula = beard.length ~ favorite.pirate,
           data = pirates,
           cex.names = .5,
           xlab = " ",
           ylab = " ",
           main = "My First Pirate Plot!")



#title( xlab="Favorite Pirate", ylab="Beard legnth", adj=0.5, cex.axis=0.4)

# OR adjust everything yourself to create a custom plot

#we are going to create a dataframe to tell us how many datapoints there are for each pirate
nlabels <- table(pirates$favorite.pirate) 
dfnlabels<-data.frame(nlabels)
View(dfnlabels)


# Then we will statistically test between the groups using a pairwise wilcox test
test  <-  pairwise.wilcox.test(pirates$parrots, pirates$favorite.pirate, p.adj="bonferroni", exact=FALSE)
# test  <-  pairwise.wilcox.test(et.ef, s.t, p.adj="holm", exact=FALSE)

test$p.value

(a <- melt(test$p.value))
a.cc  <-  na.omit(a)
a.pvals  <-  a.cc[, 3]
names(a.pvals)  <-  paste(a.cc[, 1], a.cc[, 2], sep="-")
a.pvals

#create letter labels to indicate the difference between groups
ml<-multcompLetters(a.pvals,reversed = TRUE)

# ....put those labels in a dataframe
dfml<-data.frame(print(ml))
dfml<-setNames(cbind(rownames(dfml), dfml, row.names = NULL), 
         c("Var1","Letters"))

# and merge the label dataframes together using 'sqldf'
dflabels<- merge(dfnlabels, dfml, by = c("Var1"))

#set margins of document for our new custom figure
par(mfrow = c(1, 1), mar=c(4,4.5,2,2))

#create a custom pirate plot! (yar)
pirateplot(formula =  parrots ~ favorite.pirate ,
                   data = pirates,
                   pal=my.pirate.pal, #set to your own color palette created previously
                   xlab = "Favorite Pirate",
                   ylab = "Number of Parrots",
                   main = "My Amazing Custom Pirate Plot",
                   theme=0, #set theme to 0
                   bean.f.o = .4, # Bean fill
                   point.o = .4, # Points
                   inf.f.o = .4, # Inference fill
                   inf.b.o = .8, # Inference border
                   avg.line.o = 0.8, # Average line
                   point.cex = .5, # Points
                   quant = c(.1, .9), # Adjust quantiles
                   ylim=c(0, 9))  # Adjust y axis limits
text(x = c(1,2,3,4,5,6), y=7.2 , labels=paste(dflabels$Freq), cex=1.2) #print number of rows of data
text(x = c(1,2,3,4,5,6), y=8.5 , labels=paste(dflabels$Letters), cex=1.2) #print letters indicating 
                                                                          #staistical differentitation 
                                                                         #between groups
     
    
