library(stringr)
setwd('~/Dropbox/Papers pending/Bayesian MA lit review')
con<-file('cinahl-update-MA.txt',open='r')
cinahl<-readLines(con)
close(con)
cinahl_record_date<-cinahl[str_sub(cinahl,1,3)=="RD-"]
cinahl_citation<-cinahl[str_sub(cinahl,1,3)=="SO-"]
cinahl_citation_year<-rep("",length(cinahl_citation))
cinahl_length<-length(cinahl_citation)
pb<-txtProgressBar(min=0,max=cinahl_length,style=3)
for(i in 1:cinahl_length) {
  setTxtProgressBar(pb,i)
  temp<-str_locate_all(cinahl_citation[i],"201")
  temp1<-temp[[1]][dim(temp[[1]])[1],1]
  temp2<-temp[[1]][dim(temp[[1]])[1],2]+1
  try(cinahl_citation_year[i]<-str_sub(cinahl_citation[i],temp1,temp2))
}
close(pb)

# for checking
cinahl_citation_year_count<-str_count(cinahl_citation,"201")
yrs<-data.frame(cinahl_citation,cinahl_citation_year)
yrs<-dplyr::arrange(yrs,cinahl_citation_year)
yrs17<-dplyr::filter(yrs,cinahl_citation_year==2017)
