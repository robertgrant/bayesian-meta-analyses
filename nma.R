# network meta-analyses

setwd("~/Dropbox/Papers pending/Bayesian MA lit review")

nma<-readr::read_csv('nma.csv')

nma$nma[is.na(nma$nma)]<-"no"
table(nma$nma,nma$year)