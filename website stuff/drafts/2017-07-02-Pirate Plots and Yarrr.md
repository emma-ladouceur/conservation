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

> Note: So, I first heard about Pirate Plots from  [Rbloggers](https://www.r-bloggers.com/the-pirate-plot-an-r-pirates-favorite-plot/), who told me, 'Don't use barplots!', and showed me a convincing argument of  [why](https://www.r-bloggers.com/the-pirate-plot-2-0-the-rdi-plotting-choice-of-r-pirates/). I then found [Nathan Philips](https://ndphillips.github.io/) helpful [Pirate's Guide to R](https://ndphillips.github.io/piratesguide.html), which contains a nice section which helps one to get familiar with his package, [yarrr](https://ndphillips.github.io/yarrr.html), now available on [CRAN](https://cran.r-project.org/web/packages/yarrr/index.html), which is the package you need to create his game-changing Pirate Plots.

Pirate plots also now have pre-set [Themes](https://www.r-bloggers.com/the-new-and-improved-pirateplot-now-with-themes/) That offer options with  everything set for you, but this post will cover custom adjustments and extras, as R-bloggers already covers the themes well.

<figure style="width: 350px" class="align-left">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/pirateplot-elements.png" alt="">
  <figcaption>Itty-bitty caption.</figcaption>
</figure>

## FIRST: 
We start by loading and retrieving the necessary R packages and datasets and exploring custom color palettes

{% highlight r %}
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

{% endhighlight %}


<figure style="width: 350px" class="align-left">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/pirate_palette.pdf" alt="">
  <figcaption>Itty-bitty caption.</figcaption>
</figure>

## FIRST: 
Try out a standard pirate plot and compare it to a boring old barplot!

{% highlight r %}
# partition the document into two columns and set margins
par(mfrow = c(1, 2), mar=c(4,4.5,2,2))

# A Standard plot with no adjustments
pirateplot(formula = beard.length ~ favorite.pirate,
           data = pirates,
           cex.names = .8,
           xlab = "Favorite Pirate",
           ylab = "Beard Length",
           main = "My First Pirate Plot!")

# Standard Barplot
pirateplot(beard.length~favorite.pirate,
           data=pirates,
           cex.names = .8,
           main = "Boring Barplot",
           theme = 0, # Start from scratch
           bar.f.o = .7) # Just turn on the bars


{% endhighlight %}

<figure style="width: 350px" class="align-left">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/pirate_plot_vs_barplot.png" alt="">
  <figcaption>Itty-bitty caption.</figcaption>
</figure>

<figure style="width: 350px" class="align-left">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/Fig 2 Cumulative germination curves.png" alt="">
  <figcaption>Itty-bitty caption.</figcaption>
</figure>
The rest of this paragraph is filler for the sake of seeing the text wrap around the 150×150 image, which is **left aligned**.
Filler
filler filller
filler
filler filler
filler
filler
The rest of this paragraph is filler for the sake of seeing the text wrap around the 150×150 image, which is **left aligned**.
The rest of this paragraph is filler for the sake of seeing the text wrap around the 150×150 image, which is **left aligned**.
The rest of this paragraph is filler for the sake of seeing the text wrap around the 150×150 image, which is **left aligned**.
The rest of this paragraph is filler for the sake of seeing the text wrap around the 150×150 image, which is **left aligned**.
The rest of this paragraph is filler for the sake of seeing the text wrap around the 150×150 image, which is **left aligned**.

## NEXT: 

Prepare some data frames to label your future custom pirate plot

{% highlight r %}

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

{% endhighlight %}



<figure>
    <a href="/assets/images/posts/Fig 3 Germination rate vs T (segmented model).png"><img src="/assets/images/posts/Fig 3 Germination rate vs T (segmented model).png"></a>
        <figcaption>Segmented Model; Germination Rate vs. Temperature</figcaption>
</figure>

{% highlight r %}
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
{% endhighlight %}

<figure style="width: 350px" class="align-left">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/custom_pirate.png" alt="">
  <figcaption>Itty-bitty caption.</figcaption>
</figure>