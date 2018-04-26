# remove duplicate titles from updated search
# scoping review for Bayesian meta-analyses

setwd("~/Dropbox/Papers pending/Bayesian MA lit review")
library(stringr)

# get cinahl titles and authors (but authors have one line each...)
con<-file('cinahl-update-MA.txt',open='r')
cinahl<-readLines(con)
close(con)
cinahl_title_lines<-str_sub(cinahl,1,3)=="TI-"
cinahl_title<-cinahl[cinahl_title_lines]
# some papers are anonymous so we just take the line after the title and hope for the best
cinahl_author<-c(cinahl[-1],"x")[cinahl_title_lines]
cinahl_author[str_sub(cinahl_author,1,3)!="AU-"]<-" "

# get year
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
cinahl_citation_year_count<-str_count(cinahl_citation,"201")

# drop 2017
is2015_16<-cinahl_citation_year!=2017
# for checking
  cinahl_citation_year_count<-str_count(cinahl_citation,"201")
  yrs<-data.frame(cinahl_citation,cinahl_citation_year)
  yrs<-dplyr::arrange(yrs,cinahl_citation_year)
  yrs17<-dplyr::filter(yrs,cinahl_citation_year==2017)
cinahl_title<-cinahl_title[is2015_16]
cinahl_author<-cinahl_author[is2015_16]
cinahl_citation<-cinahl_citation[is2015_16]
rm(cinahl)

# how many words in title?
cinahl_title_words<-unlist(lapply(str_locate_all(cinahl_title," "),
                                  function(x) {
                                    dim(x)[1]+1
                                  }))
# get first 6 words of title (or everything if fewer) (remember it starts "TI- ")
cinahl_title_6<-ifelse(cinahl_title_words>6,
                       stringr::word(cinahl_title,start=2,end=7),
                       cinahl_title)

# get author surname (or equivalent)
cinahl_author_1<-stringr::word(cinahl_author,start=2,end=2)
cinahl_author_1<-str_sub(cinahl_author_1,start=1,end=(-2))
cinahl_author_1<-str_replace_na(cinahl_author_1)

# get medline titles
con<-file('medline-update-MA-titles.txt',open='r')
mt<-readLines(con)
close(con)
medline_title_lines<-c(FALSE,TRUE,(mt=="")[1:(length(mt)-2)])
medline_title<-mt[medline_title_lines]
# how many words in title?
medline_title_words<-unlist(lapply(str_locate_all(medline_title," "),
                                  function(x) {
                                    dim(x)[1]+1
                                  }))
# get first 6 words of title (or everything if fewer)
medline_title_6<-ifelse(medline_title_words>5,
                        stringr::word(medline_title,start=1,end=6),
                        medline_title)
rm(mt)

# get medline authors
con<-file('medline-update-MA-authors.txt',open='r')
ma<-readLines(con)
close(con)
medline_author_lines<-c(FALSE,TRUE,(ma=="")[1:(length(ma)-2)])
medline_author<-ma[medline_author_lines]
medline_author_1<-stringr::word(medline_author,start=1,end=1)
medline_author_1<-str_replace_na(medline_author_1)

# get medline years

# trim medline to 2015-16

# loop over cinahl, look for matches in medline
medline_dups<-cinahl_dups<-NULL
pb<-txtProgressBar(min=0,max=length(cinahl_title_6),style=3)
for(i in 1:length(cinahl_title_6)) {
  setTxtProgressBar(pb,i)
  ca<-cinahl_author_1[i]
  ct<-cinahl_title_6[i]
  if(any(medline_title_6==ct)) {
    mt_match<-which(medline_title_6==ct)
    for(j in mt_match) {
      if(!is.na(medline_author_1[j]==ca)) {
        if(medline_author_1[j]==ca) {
          medline_dups<-c(medline_dups,j)
          cinahl_dups<-c(cinahl_dups,i)
        }
      }
    }
  }
}
close(pb)


