---
title: "Binomial Effect Plots"
author: Emma Ladouceur 
layout: single
share: true
author_profile: true
read_time: true
comments: true
share: true
related: true
categories:
  - R
tags:
  - ROpensci
---

If you have binomial data and categorical variables, it can be difficult to visualise your results. Here I present a simple and rigorous solution. Includes R code and data.

> Note: This is a FAKE dataset, to be used as an example only. 

This dataset represents a list of 100 plant species. We have taken raw data and fit it into binomial categories under 3 variables;

* Petal Length = If a petal is greater than 3cm long it is 'longer' and less than 3cm 'shorter'
* Petal Width = If a petal is greater than 1.5 cm wide it is 'wider' and less than 1.5cm 'thinner' 
* Picked = Plants are given a 1 if picked and a 0 if not picked

> We want to test, are wildflowers with wider and longer petals (aka bigger flower), picked more than ones with smaller flowers?

We use a binomial GLM to test the effect of the explanatory variables , 'petal length' and 'width', on our response variable, 'picked'. Next we test the effect of the variables using the package 'effects' and finally we visualise the probabilities calculated by effects using ggplot2.

The code to reproduce the figure is below, with notes;


{% highlight r %}

# load packages
library(ggplot2)
library(effects)

# read data
dat <- read.csv("https://raw.githubusercontent.com/emma-ladouceur/codeemma/master/picked.csv",

# Run a binomial GLM with petal length and width as explanatory variables
# and whether a flower is picked or not as a response variable
pick<-glm(picked~longer.petal+wider.petal,family=binomial,data=dat)
summary(pick)

# Estimate the effect of each  explanatory variable on your reponse variable  in your model
picked.prob<-data.frame(Effect(c("longer.petal", "wider.petal"), pick)$x, 
                      Est. = plogis(Effect(c("longer.petal", "wider.petal"), pick)$fit), 
                      lower = plogis(Effect(c("longer.petal", "wider.petal"), pick)$lower),
                      upper = plogis(Effect(c("longer.petal", "wider.petal"), pick)$upper))

# View the effects table
picked.prob

# Set the upper and lower limits of the estimate to represent the error bars
limits <- aes(ymax = picked.prob$upper, ymin=picked.prob$lower)

# Plot
ggplot(picked.prob, aes(fill=wider.petal, y=Est., x=longer.petal)) + ylim(0.00, 1.00) + 
  geom_bar(stat="identity",position=dodge) + geom_errorbar(limits,  position=dodge, width=0.2, lwd=1) + 
  scale_fill_manual(values=c("#00A08A", "#35274A")) +  theme_bw() +
  labs(fill= "Petal width", x= "Petal length", y= "Probability Estimate that a flower is picked") 


{% endhighlight %}


And here is the Figure;
<figure style="width: 550px" class="align-center">
  <img src="{{ site.url }}{{ site.baseurl }}/assets/images/posts/Picked.png" alt="">
  <figcaption>Effects plot produced by ggplot2.</figcaption>
</figure>

So, here we can see  bigger flowers with wider + longer petals have a probability of being  picked the most (88% probability), wider + shorter  with a 59% probability of being picked,  longer + thinner a 35% probability of being picked,  and shorter + thinner petals (smallest flowers) a 9 % probability of being picked.


> Although this dataset is fake and unrealistic to collect, I am interested in studying the 'charisma' of flowers in the future; ie. what makes a flower beautiful? And in context of conservation biology; what makes people care about plant species?


Feel free to contact me with any questions or if the code doesn't work for you.
