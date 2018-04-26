allbayes<-c(5,12,12,12,25,18,24,49,60,69,113,113) 
allnetworkma<-c(0,1,2,1,5,6,12,20,33,53,72,83)
allma<-c(1136,1360,1599,1862,2283,2832,3711,5225,6668,7235,8776,8483)
theplot<-function(num,denom,yl,cis=FALSE) {
  allprop<-num/denom
  alllci<-qbeta(0.025,num+1,denom+1)
  alluci<-qbeta(0.975,num+1,denom+1)
  plot(2005:2016,allprop*100,ylim=c(0,2.7),xlab='',ylab=yl,
      xaxp=c(2005,2016,11),yaxp=c(0,2.5,5),xaxs='r',yaxs='i')
  ymarx<-seq(from=0,to=2.5,by=0.5)
  for(i in 1:8) {
    lines(c(2000,2020),rep(ymarx[i],2),col='lightgrey')
  }
  if(cis) {
    points(2005:2016,allprop*100)
    for(i in 1:12) {
      lines(rep(2004+i,2),c(alllci[i]*100,alluci[i]*100))
    }
  }
  else {
    lines(2005:2016,allprop*100)
  }
}

# numbers of meta-analyses
svglite::svglite('figure1.svg')
  plot(2005:2016,allma/1000,type='l',ylim=c(0,10.5),yaxs='i',
     xlab='Year',ylab='Published meta-analyses per year (1000s)')
  points(2005:2016,allma/1000)
  for(j in 2*(1:5)) {
    lines(c(2000,2020),rep(j,2),col='lightgrey')
  }
dev.off()
png('figure1.png')
plot(2005:2016,allma/1000,type='l',ylim=c(0,10.5),yaxs='i',
     xlab='Year',ylab='Published meta-analyses per year (1000s)')
  points(2005:2016,allma/1000)
  for(j in 2*(1:5)) {
    lines(c(2000,2020),rep(j,2),col='lightgrey')
  }
dev.off()

svglite::svglite('figure2.svg')
  theplot(num=allbayes,denom=allma,yl='% of meta-analyses that are Bayesian')
dev.off()
png('figure2.png')
  theplot(num=allbayes,denom=allma,yl='% of meta-analyses that are Bayesian')
dev.off()

svglite::svglite('figure3.svg')
theplot(num=allnetworkma,denom=allma,yl='% of meta-analyses that are Bayesian NMAs')
dev.off()
png('figure3.png')
theplot(num=allnetworkma,denom=allma,yl='% of meta-analyses that are Bayesian NMAs')
dev.off()


# export table
write.csv(data.frame(year=2005:2016,ma=allma,bayes=allbayes,nma=allnetworkma),
                 file="Table1.csv")

