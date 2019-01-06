rm(list=ls())
library(MASS)
ldapinv<-function(X,y,Xnew=NULL){

  #+++ Basic computation
  A<-length(y)
  B<-length(which(y==1))
  C<-A-B
  XX<-NULL
  r1<-A/B
  r2<-A/C
  R<-NULL
  
  #+++ Rearrange data
  subsetp<-which(y==1)
  subsetn<-which(y==-1)
  XXp<-cbind(X[subsetp,],rep(1,times=B))
  XXn<-cbind(-X[subsetn,],rep(-1,times=C))
  R<-c(rep(r1,times=B),rep(r2,times=C))
  #+++ Expanded data
  XX<-rbind(XXp,XXn)
  
  #+++ Compute the LDA model: Coef with the last element corresponding to intercept.
  Coef=ginv(t(XX)%*%XX)%*%t(XX)%*%R
  
  #+++ Make predictions;
  yfit<-cbind(X,rep(1,A))%*%Coef
  if (!is.null(Xnew)){
    ypred<-cbind(Xnew,rep(1,nrow(Xnew)))%*%Coef
    
  }
  
  return(list(yfit=yfit,ypred=ypred))
}
getscore<-function(set1ft,set1y,testft){
  X1=as.matrix(set1ft[1:84])
  y1=as.matrix(set1y)
  xnew2=as.matrix(testft[1:84])
  Lldap2=ldapinv(X1,y1,xnew2)
  L2SQ=data.frame(Lldap2$ypred)
  return(L2SQ)
}
args<-commandArgs(TRUE)
posi<-read.table(args[1])
nega<-read.table(args[2])
hig=(data.frame(posi[1:84]/posi$V85,1))
low=(data.frame(nega[1:84]/nega$V85,-1))
colnames(low)=colnames(hig)
hig1=hig[1:floor(nrow(hig)/2),]
hig2=hig[floor(nrow(hig)/2+1):nrow(hig),]
low1=low[1:floor(nrow(low)/2),]
low2=low[floor(nrow(low)/2+1):nrow(low),]
set1=rbind(low1,hig1)
set2=rbind(low2,hig2)
h1score=getscore(set2,set2[85],hig1[1:84] )
h2score=getscore(set1,set1[85],hig2[1:84] )
l1score=getscore(set2,set2[85],low1[1:84] )
l2score=getscore(set1,set1[85],low2[1:84] )
Hscore=rbind(h1score,h2score)
Lscore=round(rbind(l1score,l2score),3)
write.table(Lscore,paste(args[2], ".sqscore", sep = ""),row.names = FALSE,col.names = FALSE)
