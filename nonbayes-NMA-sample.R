# select nonbayes NMA sample for review

setwd('/Users/robert/Dropbox/Papers pending/Bayesian MA lit review')
set.seed(545028)
samplesize<-81
spares<-100 # a few spares
sample_and_spares<-samplesize+spares

# ref number to start each splitfile (beware of overlapping abstracts...)
startref<-c(0,2176,4477,6840,9231,11620,14038,16425,18849,21268,23740,26225,28724,31234)


# get all refs
refs<-read.csv('nonbayes-NMA-search-results1.csv')
for(i in 2:14) {
  temp<-read.csv(paste0('nonbayes-NMA-search-results',i,'.csv'))
  temp$ref<-temp$ref+startref[i]
  refs<-rbind(refs,temp)
}
nrefs<-dim(refs)[1]
samplenumbers<-sample(1:nrefs,sample_and_spares)
samplerefs<-refs[samplenumbers[1:samplesize],]
sparerefs<-refs[samplenumbers[(samplesize+1):sample_and_spares],]