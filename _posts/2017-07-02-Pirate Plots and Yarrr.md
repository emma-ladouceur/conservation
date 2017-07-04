---
title: "Pirate Plots & Yarrr"
author: Emma Ladouceur
layout: single
share: true
author_profile: true
read_time: true
comments: true
share: true
related: true
categories:
  - Rstats
tags:
  - Rstats
---

I have been using 'Pirate Plots' in alot of my work lately and have had a few inquiries as to how to create them. The answer is; it's easy. Here I present R code and use the example 'pirates' dataset from the package, 'yarrr' to demonstrate, how to get your pirate plots publication ready, and to your liking.

> Note: I first heard about Pirate Plots from [Rbloggers](https://www.r-bloggers.com/the-pirate-plot-an-r-pirates-favorite-plot/), who told me, 'Don't use barplots!', and showed me a convincing argument of  [why](https://www.r-bloggers.com/the-pirate-plot-2-0-the-rdi-plotting-choice-of-r-pirates/). I then found [Nathan Philips](https://ndphillips.github.io/) helpful [Pirate's Guide to R](https://ndphillips.github.io/piratesguide.html), which contains a nice section which helps one to get familiar with his package, [yarrr](https://ndphillips.github.io/yarrr.html), now available on [CRAN](https://cran.r-project.org/web/packages/yarrr/index.html), which is the package you need to create his game-changing Pirate Plots.

Pirate plots also now have pre-set [Themes](https://www.r-bloggers.com/the-new-and-improved-pirateplot-now-with-themes/) That offer options with  everything set for you, but this post will cover custom adjustments and extra tweaks to create a publication-ready pirate plot, as R-bloggers already covers the themes well.

> To The Point: Why a Pirate Plot? Well it doesn't take much convincing when you examine the elements of a pirate plot below:

<figure class="align-center">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/pirateplot-elements.png" alt="">
  <figcaption> Anatomy of a Pirate Plot. Raw data points, center line, bean density, and a fancy Bayesian 95% Inference Band! </figcaption>
</figure>

## FIRST: 
We start by loading and retrieving the necessary R packages and datasets and exploring custom color palettes

{% highlight r %}
#make sure you have all these packages first!
install.packages("yarrr")  # Install package from CRAN
library("yarrr") # Load the package
#for data manipulation
library(multcompView)
library(reshape)
library(sqldf)

piratepal() #view all pirate color palettes
piratepal(palette = "basel") #view the color codes from a specific palette

View(pirates) # We will use the provided dataset 'pirates'

{% endhighlight %}

Below is the complete pirate palette offered. Of course, you can create your own custom palettes, and this post will show you how!

<figure  class="align-center">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/pirate_palette.png" alt="">
  <figcaption>The complete Pirate Palette automatically configured.</figcaption>
</figure>

## NEXT: 
Try out a standard pirate plot and compare it to a boring old barplot and a standard box and whiskers plot.

{% highlight r %}
# partition the figure document into three columns and set margins
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


# And I even find pirate plots better than a boxplot because a boxplt can hide whats 
# happening behind the summarized box and whiskers
boxplot(beard.length~favorite.pirate,
        data=pirates, cex.axis=0.75, mtext("Normal Boxplot", xlab="Favorite Pirate", 
        font=2,side = 3, line = -1.5, cex=.75, outer = TRUE),
        mtext("Favorite Pirate", 
            font=2, side = 3, line = -52.5, cex=.75, outer = TRUE),
                            title(ylab="Beard legnth"))

# A Standard pirate plot with no adjustments shows you exactly whats happening with your data!
pirateplot(formula = beard.length ~ favorite.pirate,
           data = pirates,
           cex.names = .5,
           xlab = " ",
           ylab = " ",
           main = "My First Pirate Plot!")


{% endhighlight %}

<figure class="align-center">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/pirate_plot_vs_barplot.png" alt="">
  <figcaption>Shark vs. Bear? Pirate Plot vs. Barplot & Box plot! Jack Sparrows Beard vs. the world. </figcaption>
</figure>


## NEXT: 

Prepare some data frames to label your future custom pirate plot. Next we will look at number of parrots per pirate next as its clear to us Jack Sparrows Beard wins. No further beard analysis necessary. We will labels our custom plot to clearly tell the reader the number of data points (who likes which pirate more?), and label the statistical differences between groups right on the plot, based in a pairwise.wilcox test using the package [MultcompView](https://cran.r-project.org/web/packages/multcompView/index.html). We will merge the data frames together into one using [sqldf](https://cran.r-project.org/web/packages/sqldf/index.html).

{% highlight r %}

# We are going to create a data frame to tell us how many data points there are for each pirate
# I have found this helpful in  my ecological work to make the quality of the data and results very clear to the reader
# (ie. Jack Sparrow is everyone's favorite pirate by a long shot!)
nlabels <- table(pirates$favorite.pirate) 
dfnlabels<-data.frame(nlabels)
View(dfnlabels)


# Then we will statistically test between the groups using a pairwise wilcox test (cause pirates ain't normal)
test  <-  pairwise.wilcox.test(pirates$parrots, pirates$favorite.pirate, p.adj="bonferroni", exact=FALSE)

test$p.value

(a <- melt(test$p.value))
a.cc  <-  na.omit(a)
a.pvals  <-  a.cc[, 3]
names(a.pvals)  <-  paste(a.cc[, 1], a.cc[, 2], sep="-")
a.pvals # How's your p-values looking?

# Create letter labels to indicate the difference between groups with 'MultcompView'
ml<-multcompLetters(a.pvals,reversed = TRUE)

# ....put those labels into a dataframe
dfml<-data.frame(print(ml))
dfml<-setNames(cbind(rownames(dfml), dfml, row.names = NULL), 
         c("Var1","Letters"))

# ....and merge the label dataframes together using 'sqldf'
dflabels<- merge(dfnlabels, dfml, by = c("Var1"))

# I am well aware there are more elegant ways to do this. This is just my quick solution. I welcome comments suggesting more elegant approaches. Elegancy in R is not yet my strong suit.

{% endhighlight %}


So now we have two data frames that we have merged together into two columns of one data frame; one that tells us how many data points comprise each variable, and one that indicates the statistical difference between our groups. We will use these to label our custom plot.

## AND FINALLY: 
Create your very own custom-tailored pirate plot!

{% highlight r %}
# Make your own custom color palette!
my.pirate.pal<-c("#7F8624FF", "#4D709CFF","#170C2EFF","#52194CFF","#751029FF", "#F2990CFF" )

# Set margins of document for our new custom figure
par(mfrow = c(1, 1), mar=c(4,4.5,2,2))

# Create a custom pirate plot! (yar!)
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

And of course, querying 'Pirate Plot' will show you all custom specifications possible!
??pirateplot # here

{% endhighlight %}

<figure class="align-center">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/custom_pirate.png" alt="">
  <figcaption> Your first custom Pirate Plot! When using pirate plots in my work I use the following legend (to be amended, of course to anything you change in your custom pirate plot): RDI plots (Raw data, Descriptive and Inference statistics) show jittered points of raw data, centre bars indicate the mean of the data, beans outline the smoothed density of the data, whiskers mark the 10% and 90% quartiles of the data, and inference bands show the Bayesian 95% High Density Interval inferential statistics for each group. Numbers at the top of each group indicates the number of data points for each trait, and letters show statistical differences between groups.</figcaption>
</figure>

I have checked this legend with Nathan Philips and he agreed it was appropriate and descriptive. He asks when using yarrr in published work to always cite it! Pirate plots are now capable of having up to three independent variables displayed in one [plot](https://www.r-bloggers.com/the-yarrr-package-0-0-8-is-finally-on-cran/). 

> For me, the bottom line is: Pirate plots help me and my readers understand the data better!

I must be an outlier myself, as I am partial to Long John Silver as my favorite pirate, based on the show I've been watching, [Black Sails](https://youtu.be/Pvxpv_fycl8). I welcome any questions or comments you might have. Comment below.

