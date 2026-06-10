# Data Science Resources And Training

## Welcome!
This repository acts as a central hub for access to Data Science tutorials, developed primarily for University of Edinburgh PhD students, and developed by Edinburgh staff, but available to anyone that might find things useful. The content leans environmental science/ecology heavy at the moment, we hope to expand to include more and are always open to suggestions (put them in the 'issues' tab at the top of the page).

## How to navigate this webpage
If you're unfamiliar with Github, start with [this tutorial](https://ourcodingclub.github.io/tutorials/git/) to get yourself clued in a bit. In short, Github is used for people to collaboratively code - it's not always the most intuitive to use but if you can be brave it pays to get familiar. Above you'll see file/folder names (left column), the next column over is comments from whoever last edited that file/folder saying what they dud and then next when that edit was made (this info is useful when doing group work, less useful in the context we're using this so just ignore it).

Files can be downloaded using the little arrow in the top right on pages. 

## What resources you'll find here
At the moment you can find some resources for learning linear modelling and a few other bits _in R_. We'd love to expand to include Python tutorials here too, please get in touch if you have any to recommend.

- [Linear Models](/LinearModels) (4 tutorials starting at the basics and ramping up. Would recommend you browse the 'Why is Stats so Confusing' lecture under '[ExtraResources](/ExtraResources)' to reassure yourself before starting). See the 'ReadMe' section under each for instructions.
- [Visualisation](/Visualisation) (to help you in making pretty plots)
- [Spatial Data](/SpatialData) (for working with raster and vector data)

You can either just download the files and work locally from your computer, but if you want to stay hooked into github, you'll first need to fork the repository (see the little 'fork' button next to 'watch' in the upper right), then you can clone it and make edits as you will. If that was all gobbledygook refer back to ^ that tutorial above.

## Links to other resources
Below we'll include links to a bunch of other resources that you might find useful. You can also see the extra resources folder up above, this is a bit of a grab bag at the moment but will be tidied! A lot of the following leans on the Coding Club course that's walked through [here](https://ourcodingclub.github.io/course), you could also just work through that if it works for you.

We're all ears to new suggestions! If you find a good tutorial, please send it on so we can start building up a bigger base of resources. 

For if you're totally new to R/Stats:
- Coding Club Tutorials
    - [Basic data manipulation in R](https://ourcodingclub.github.io/tutorials/data-manip-intro/)
    - [Efficient data manipulation in R](https://ourcodingclub.github.io/tutorials/data-manip-efficient/)
    - [Coding Etiquette](https://ourcodingclub.github.io/tutorials/etiquette/)
- Extra Reading
    - [R Studio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/) - this are super helpful, many a data scientist has them printed and stuck on the wall!
    - [The TidyVerse](https://www.tidyverse.org/)
    - [R for Data Science Chapter 5 Data transformation](http://r4ds.had.co.nz/transform.html)
    - [R for Data Science Part II Wrangle Chapters 9 - 16](http://r4ds.had.co.nz/wrangle-intro.html)

For Data Visualization
- The above ggplot tutorial
- Coding Club tutorials
    - [Beautiful and informative data visualisation in R](https://ourcodingclub.github.io/tutorials/datavis)
    - [Customising your figures](https://ourcodingclub.github.io/tutorials/data-vis-2/)
- Readings
    - [R for Data Science Chapter 3 Data visualisation](http://r4ds.had.co.nz/data-visualisation.html])
    - [R for Data Science Chapter 28 Graphics for communication](http://r4ds.had.co.nz/graphics-for-communication.html)

## How do I know which resources I need?
Here's some things to think about to help you (note that the linked sources are not at all exhaustive and possibly not always that useful, but the goal is to just give you a place to start):
- If you're asking a question about association (as one thing goes up, does another? Is there a difference between these groups?), you want linear models. These can be done in either a frequentist framework (as in the tutorials in this Github) or [Bayesian](https://ourcodingclub.github.io/tutorials/brms/).
- If you're asking a question about causation (does one thing cause a change in another? Has a change in something impacted something else?), you want to look into [impact evaluation](https://scb-impact.org/what-is-impact-evaluation/) or causal inference methods (here is one of a thousand [intros](https://matheusfacure.github.io/python-causality-handbook/05-The-Unreasonable-Effectiveness-of-Linear-Regression.html)). You may still use linear models in this kind of approach, just in a different way
- If you're wanting to extract data from maps, you need to learn GIS skills. There are many many youtube tutorials that help with this. See the Spatial Data tutorial in this GitHub to get a beginners look at kinds of spatial data, but you may also find you want to look at your data through an interface (where you can actually look at the maps) rather than via code. In that case have a play with QGIS, here's a great [beginners tutorial](https://www.youtube.com/watch?v=pGm7w-LywO0). Once you've extracted your spatial data you may then want to use it in some form of statistical modelling (e.g. linear models), but you'll probably need to account for [spatial autocorrelation](https://rspatial.org/analysis/3-spauto.html), because points that are closer together are more likely to be similar, violating the assumption of models that each data point is totally independent. This can be done in linear models with a number of packages e.g. [nlme](https://stats.oarc.ucla.edu/r/faq/how-do-i-model-a-spatially-autocorrelated-outcome/)
- If you're working with time series data you'll need to think about temporal autocorrelation (the idea that each time point isn't independent because it will be affected by the time point(s) beforehand). You may also want to think about decomposition, e.g. if your time series is seasonal then you might want to remove the effect of 'season' before seeing if some other variable affects your time series. There's a bit of a primer [here](https://ourcodingclub.github.io/tutorials/time/).
- If you've got multivariate data (multiple response variables) you might want to consider using [PCA](https://www.nature.com/articles/s43586-022-00184-w)/NDMS aka [ordination] (https://ourcodingclub.github.io/tutorials/ordination/)/[PermANOVA](https://uw.pressbooks.pub/appliedmultivariatestatistics/chapter/permanova/) approaches
- If you're modelling 



