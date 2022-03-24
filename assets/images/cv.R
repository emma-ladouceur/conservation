

devtools::install_github("ndphillips/VisualResume")
library(VisualResume)
library(yarrr)
library(MetBrewer)

VisualResume::VisualResume(
#timeline.labels = c("Education", "Teaching"),
timeline = data.frame(title = c("Ryerson University", "University of Toronto", "Environmental Planner", "University of Queensland",
                                "University of Queensland \n Centre for Mined Land Rehabilitation \n Queensland University of Technology", "University of Pavia & \n Museo delle Scienze (MUSE)" ,"iDiv", "iDiv"),
                      sub = c("Bachelor of Urban and Regional Planning", "Dipl. Environmental Mgmt.", "Non-profit, public, private sectors", "MSc Conservation Biology"," \n \n \n  \n Tutor, Restoratioin Researcher & Practitioner", 
                              " \n \n  \n Marie-Curie Initial Training Network (ITN) ECR \n PhD Earth & Environmental Science", "Postdoc", "Alexander von Humboldt Fellow"),
                      start = c(2003, 2008,2007, 2011, 2011.5, 2014, 2018, 2020),
                      end = c(2007,2009, 2011, 2012, 2014, 2018, 2020, 2022),
                      side = c(1, 1, 0 , 1, 0, 1, 1,1)),
milestones = data.frame(title = c("BA", "MS", "PhD"),
                        sub = c("Math", "Chemistry", "Chemistry"),
                        year = c(1980, 1982, 1985)),
events = data.frame(year = c( 2003, 2011, 2014, 2018),
                    title = c("Canada",
                              "Australia",
                              "Italy",
                              "Germany")),
col = (palette = c("#7c668c", "#b08ba5", "#dfbbc8", "#ffc680", "#ffb178", "#db8872", "#a56457")),
interests = list("programming" = c(rep("R", 10), rep("Python", 1), rep("JavaScript", 2), "MatLab"),
                 "statistics" = c(rep("Decision Trees", 10), rep("Bayesian", 5), rep("Regression", 3)),
                 "leadership" = c(rep("Motivation", 10), rep("Decision Making", 5), rep("Manipulation", 30))),
year.steps = 2
)

