library(stringr)
facts<-readLines('medline-bayes-fulltext-notes.txt')
facts<-t(matrix(facts,nrow=12))
facts[,c(3,4,5,11,12)]<-str_sub(facts[,c(3,4,5,11,12)],start=3)
facts[,6:10]<-str_sub(facts[,6:10],start=2)
facts<-facts[,-1]
facts<-cbind(rep('medline',dim(facts)[1]),facts)
colnames(facts)<-c('database',
                   'number',
                   'code',
                   'data',
                   'software',
                   'ancestors',
                   'problem',
                   'success',
                   'model',
                   'priors',
                   'freq_and_bayes',
                   'justified')
allfacts<-facts
facts<-readLines('cinahl-bayes-fulltext-notes.txt')
facts<-facts[1:(length(facts)-1)]
facts<-t(matrix(facts,nrow=12))
facts[,c(3,4,5,11,12)]<-str_sub(facts[,c(3,4,5,11,12)],start=3)
facts[,6:10]<-str_sub(facts[,6:10],start=2)
facts<-facts[,-1]
facts<-cbind(rep('cinahl',dim(facts)[1]),facts)
colnames(facts)<-c('database',
                   'number',
                   'code',
                   'data',
                   'software',
                   'ancestors',
                   'problem',
                   'success',
                   'model',
                   'priors',
                   'freq_and_bayes',
                   'justified')
allfacts<-rbind(allfacts,facts)
allfacts<-cbind(allfacts,rep(0,dim(allfacts)[1]),rep("",dim(allfacts)[1]))
colnames(allfacts)[13]<-'year'
colnames(allfacts)[14]<-'citation'

# attach year 
cinahlyears<-read.csv('cinahl-bayes-info.csv',stringsAsFactors=FALSE)
medlineyears<-read.csv('medline-bayes-info.csv',stringsAsFactors=FALSE)
for(i in 1:(dim(allfacts)[1])) {
  db<-allfacts[i,'database']
  dbno<-allfacts[i,'number']
  allfacts[i,'year']<-get(paste0(db,'years'))[dbno,'pubyear']
  allfacts[i,'citation']<-get(paste0(db,'years'))[dbno,'citations']
}

View(table(allfacts[,'code']))
View(table(allfacts[,'data']))
View(table(allfacts[,'software']))
View(table(allfacts[,'problem']))
sum(table(allfacts[,'problem'])[str_detect(names(table(allfacts[,'problem'])),'diag')])
sum(table(allfacts[,'problem'])[str_detect(names(table(allfacts[,'problem'])),'risk')])
sum(table(allfacts[,'problem'])[str_detect(names(table(allfacts[,'problem'])),'gene')])
sum(table(allfacts[,'problem'])[str_detect(names(table(allfacts[,'problem'])),'genom')])
View(table(allfacts[,'success']))
View(table(allfacts[,'model']))
View(table(allfacts[,'priors']))
# priors table is written out to priors.csv and manually classified
pri<-read.csv('priors.csv')
table(pri$Freq,pri$given)
sum(pri$Freq[pri$given=='n'])
sum(pri$Freq[pri$given=='p' | pri$given=='?'])
sum(pri$Freq[pri$given=='x'])
pri2<-dplyr::filter(pri,given=='y')
sum(pri2$Freq[pri2$type=='d'])
sum(pri2$Freq[pri2$type=='e'])
sum(pri2$Freq[pri2$type=='s'])
sum(pri2$Freq[pri2$type=='w'])
sum(pri2$Freq[pri2$type=='mix' | pri2$type=='?'])
View(table(allfacts[,'freq_and_bayes']))
q8<-as.matrix(table(allfacts[,'freq_and_bayes'],allfacts[,'justified']))
q8b<-q8[10,]
View(as.matrix(q8b))

# ancestors are classified manually
write.csv(allfacts,'allfacts.csv')