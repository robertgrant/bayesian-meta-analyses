setwd('/Users/robert/Dropbox/Papers pending/Bayesian MA lit review')
library(stringr)
mt<-readLines('medline-collapsed-MA-titles.txt')
mtw<-1+str_count(mt," ")
mtw[mtw>6]<-6
mt2<-word(mt,start=1,end=mtw)
#rm(mt)
ma<-readLines('medline-collapsed-MA-authors.txt')
ma2<-word(ma,start=1,end=1)
#rm(ma)
ct<-readLines('cinahl-MA-titles.txt')
ctw<-1+str_count(ct," ")
ctw[ctw>6]<-6
ct2<-word(ct,start=1,end=ctw)
#rm(ct)
ca<-readLines('cinahl-MA-authors.txt')
ca2<-word(ca,start=1,end=1)
#rm(ca)
matches<-allmatches<-NULL
pb<-txtProgressBar(min=1,max=length(ct2),style=3)
for(i in 1:length(ct2)) {
  setTxtProgressBar(pb,i)
  tmatch<-match(ct2[i],mt2)
  allmatches[[i]]<-tmatch
  if(length(tmatch)>1) {
    tmatch<-tmatch[1]
  }
  if(!is.na(tmatch) & ca2[i]==ma2[tmatch]) {
    matches<-rbind(matches,c(i,tmatch))
  }
}
close(pb)
for(i in (dim(matches)[1])) {
  mtmatch<-mt2[matches[i,2]]
  mamatch<-ma2[matches[i,2]]
  ctmatch<-ct2[matches[i,1]]
  camatch<-ca2[matches[i,1]]
}
potential_dups<-data.frame(cinahl_no=matches[,1],
                           medline_no=matches[,2],
                           cinahl_title=ct[matches[,1]],
                           medline_title=mt[matches[,2]],
                           cinahl_author=ca[matches[,1]],
                           medline_author=ma[matches[,2]])
write.csv(potential_dups,'potential-duplicates-MA.csv')