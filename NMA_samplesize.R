# sample size calculation for scoping review of Bayesian MAs
#  - to find what proportion of Network Meta-analyses that don't mention Bayes / Credible intervals
#    in the abstract or title actually turn oout in full-text to be Bayesian
#     we are aiming for CrI 30%-50% width around a putative 40% rate.
#     prior is beta(2,3)

ssizes<-(5:100)
prior_shape1<-2
prior_shape2<-3
iter<-1000

nss<-length(ssizes)
lci<-uci<-rep(NA,nss)
for(i in 1:nss) {
  ss<-ssizes[i]
  n_bayes<-round(ss*(prior_shape1/(prior_shape1+prior_shape2)))
  n_freq<-ss-n_bayes
  posterior_shape1<-prior_shape1+n_bayes
  posterior_shape2<-prior_shape2+n_freq
  lci[i]<-qbeta(p=0.025,shape1=posterior_shape1,shape2=posterior_shape2)
  uci[i]<-qbeta(p=0.975,shape1=posterior_shape1,shape2=posterior_shape2)
}
plot(ssizes,lci,type="l",ylim=c(0,1))
lines(ssizes,uci)
lines(ssizes,rep(0.3,nss),col="red")
lines(ssizes,rep(0.5,nss),col="red")

uci_threshold<-floor((which(uci<0.5)[1]+which(uci>0.5)[length(which(uci>0.5))])/2)
lci_threshold<-floor((which(lci>0.3)[1]+which(lci<0.3)[length(which(lci<0.3))])/2)
sample_size<-floor((uci_threshold+lci_threshold)/2)

last_ref_per_splitfile<-c(2178,4477,6840,9231,11620,14038,)
  # note some of these are split over files, and are named here where the first line appears
n_splitfiles<-length(last_ref_per_splitfile)
refs_per_splitfile<-c(last_ref_per_splitfile[1],
                      last_ref_per_splitfile[2:n_splitfiles]-last_ref_per_splitfile[1:(n_splitfiles-1)])