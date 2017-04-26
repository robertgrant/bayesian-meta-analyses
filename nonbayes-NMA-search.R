setwd('/Users/robert/Dropbox/Papers pending/Bayesian MA lit review')
library(stringr)
for(filenumber in 1:14) {

con<-file(paste0('split',filenumber,'.csv'))
x<-readLines(con)
close(con)

# find NMAs
res<-data.frame(ref=0,line=0)
nlines<-length(x)
pb<-txtProgressBar(min=1,max=nlines,style=3)
ref<-0
for(i in 2:nlines) {
  setTxtProgressBar(pb,i)
  if(x[i]=="" & x[i-1]=="") {
    ref<-ref+1
  }
  if(str_detect(x[i],"etwork meta") | str_detect(x[i],"ndirect")) {
    res<-rbind(res,c(ref,i))
  }
}
close(pb)
write.csv(res,file=paste0("NMA-search-results",filenumber,".csv"))

# find Bayesian references
res2<-data.frame(ref=0,line=0)
pb<-txtProgressBar(min=1,max=nlines,style=3)
ref<-0
for(i in 2:nlines) {
  setTxtProgressBar(pb,i)
  if(x[i]=="" & x[i-1]=="") {
    ref<-ref+1
  }
  if(str_detect(x[i],"ayes") | str_detect(x[i],"credible") | str_detect(x[i],"BUGS")) {
    res2<-rbind(res2,c(ref,i))
  }
}
close(pb)
write.csv(res2,file=paste0("bayes-search-results",filenumber,".csv"))

# select NMAs not in the Bayes list
res3<-as.numeric(names(table(res$ref[-1])))
temp<-as.numeric(names(table(res2$ref[-1])))
for(i in 1:(length(temp))) {
  if(any(res3==temp[i])) {
    res3<-res3[-(which(res3==temp[i]))]
  }
}
write.csv(data.frame(ref=res3),file=paste0("nonbayes-NMA-search-results",filenumber,".csv"))
}
