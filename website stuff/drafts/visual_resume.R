
#example
#install.packages("devtools") # Only if you don't have the devtools package
devtools::install_github("ndphillips/VisualResume")

VisualResume::VisualResume(
  titles.left = c("Walter White, PhD", "Chemistry, Cooking, Pizza", "*Built with love in R using the VisualResume package: www.ndphillips.github.io/VisualResume"),
  titles.right = c("www.lospolloshermanos.com", "TheOneWhoKnocks@gmail.com", "Full Resume: https://ndphillips.github.io/cv.html"),
  timeline.labels = c("Education", "Teaching"),
  timeline = data.frame(title = c("Grinnell Col", "Ohio U", "U of Basel", "Max Planck Institute", "Old Van", "Gray Matter", "Sandia Laboratories", "J.P. Wynne High School", "A1A Car Wash"),
                        sub = c("BA. Student", "MS. Student", "PhD. Student", "PhD. Researcher", "Methamphetamine Research", "Co-Founder", "Chemist", "Chemistry Teacher", "Co-Owner"),
                        start = c(1976, 1980.1, 1982.2, 1985, 1996.5, 1987, 1991, 1995, 2001),
                        end = c(1980, 1982, 1985, 1987, 1998, 1992, 1995, 1998, 2003),
                        side = c(1, 1, 1, 1, 1, 0, 0, 0, 0)),
  milestones = data.frame(title = c("BA", "MS", "PhD"),
                          sub = c("Math", "Chemistry", "Chemistry"),
                          year = c(1980, 1982, 1985)),
  events = data.frame(year = c(1985, 1995, 1997, 1999, 2000),
                      title = c("Contributed to Nobel Prize winning experiment.",
                                "Honorary mention for best Chemistry teacher of the year.",
                                "Created Blue Sky, the most potent methamphetamine ever produced.",
                                "Made first $1,000,000.",
                                "White, W., & Pinkman, J. (2000). Blue Sky: A method of [...].\nJournal of Psychopharmical Substances, 1(1),.")),
  interests = list("programming" = c(rep("R", 10), rep("Python", 1), rep("JavaScript", 2), "MatLab"),
                   "statistics" = c(rep("Decision Trees", 10), rep("Bayesian", 5), rep("Regression", 3)),
                   "leadership" = c(rep("Motivation", 10), rep("Decision Making", 5), rep("Manipulation", 30))),
  year.steps = 2
)



#me
VisualResume::VisualResume(
  titles.left = c("Visual CV", "",""),
  titles.right = c("", "", ""),
  timeline.labels = c("Education & Experience", "Review & Teaching"),
  timeline = data.frame(title = c("Ryerson University","City of Toronto","U of T","UQ","UQ","CMLR","Australia","QUT","U of Pavia", "Museo delle Scienze","Museo delle Scienze", "Conservation Letters"),
                        sub = c("BA. Student", "Environmental Planner", "Cert. Env. Mgmt.", "MSc Student","Tutor", "Research Officer", "Tree Planter", "Lab Manager & Tutor", "Ph.D Student", " Marie Curie Early Stage Researcher", "Researcher", "Social Media Editor"),
                        start = c(2003.5, 2007.6, 2008, 2011,2011.5, 2012.5, 2013.5, 2013.7, 2014.7, 2014.7,2017.7, 2017.6),
                        end = c(2007.5, 2010.9, 2009.5, 2012.5,2012.5, 2013.5, 2014.4, 2014.6, 2017.8, 2017.7,2018.4, 2019),
                        side = c(1, 0, 1, 1, 0, 1, 0, 1,1,0,0,1)),
  milestones = data.frame(title = c("", ""),
                          sub = c("", ""),
                          year = c("","")),
  events = data.frame(year = c(2007.5, 2009.5,2012.5,2013,2014.2,2017.8),
                      title = c("BA Urban Planning, Ryerson University (RU), Toronto, Canada", "Certificate of Environmental Management, University of Toronto (U of T)", "MSc Conservation Biology, University of Queensland (UQ), Australia", "Centre for Mined Land Rehabilitation (CMLR), University of Queensland", "Jennifer Firn Lab, Queensland University of Technology (QUT)", "PhD, Earth & Environmental Scince, University of Pavia, Italy")),
  interests = list("Ecology" = c(rep("Vegetation", 2), rep("Seeds", 2), rep("Restoration", 2), rep("Applied", 2)),
                   "Cons. Bio" = c(rep("Trophic Web", 2), rep("Management", 2), rep("Rarity", 2), rep("Pollinators", 2)),
                  "Planning" = c(rep("Ecological Design", 2), rep("Decision Making", 2), rep("Environmental", 2), rep("Urban", 2))),
  col = "basel",
  trans = .6)
