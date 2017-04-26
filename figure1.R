allbayes<-c(7,17,17,15,30,22,30,59,73,83,34)
allma<-c(1136,1360,1599,1862,2283,2832,3711,5225,6668,7235,1349)
allprop<-allbayes/allma
alllci<-qbeta(0.025,allbayes+1,allma+1)
alluci<-qbeta(0.975,allbayes+1,allma+1)
theplot<-function() {
plot(2005:2015,allprop*100,ylim=c(0,3.7),xlab='',ylab='Percentage of Bayesian papers',
     xaxp=c(2005,2015,10),yaxp=c(0,3.5,7),xaxs='r',yaxs='i')
ymarx<-seq(from=0,to=3.5,by=0.5)
for(i in 1:8) {
  lines(c(2000,2020),rep(ymarx[i],2),col='lightgrey')
}
points(2005:2015,allprop*100)
for(i in 1:11) {
  lines(rep(2004+i,2),c(alllci[i]*100,alluci[i]*100))
}
}
svglite::svglite('figure1.svg')
theplot()
dev.off()
png('figure1.png')
theplot()
dev.off()