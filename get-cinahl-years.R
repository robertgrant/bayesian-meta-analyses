library(stringr)

######## for MA ########
# read in citations
citations<-readLines('cinahl-MA-citations.txt')
# cut ISSN, PMID, CINAHL AN
cinahlanloc<-str_locate(citations,"CINAHL AN:")
pmidloc<-str_locate(citations,"PMID:")
issnloc<-str_locate(citations,"ISSN:")
trimloc<-apply(cbind(cinahlanloc[,1],pmidloc[,1],issnloc[,1]),1,min,na.rm=TRUE)
citations<-str_sub(citations,start=1,end=(trimloc-1))
# remove duplicates
dups<-read.csv('confirmed-duplicates-MA.csv')[,'cinahl_no']
citations<-citations[-dups]

############ for bayes ##########
citations<-readLines('cinahl-bayes-citations.txt')




# detect years
for(yr in 2005:2015) {
  assign(paste0('year',yr),str_detect(citations,fixed(as.character(yr),FALSE)))
}
years<-data.frame(year2005,year2006,year2007,year2008,year2009,year2010,year2011,year2012,
                  year2013,year2014,year2015)
# count instances of each year
yearcounts<-apply(years,2,sum)
# count citations with more than one
morethanone<-apply(years,1,function(x){sum(x)>1})
pubyear<-rep(0,dim(years)[1])
for(yr in 2005:2015) {
  pubyear[get(paste0('year',yr))]<-yr
}
info<-data.frame(pubyear,citations)
write.csv(info,'cinahl-MA-info.csv')