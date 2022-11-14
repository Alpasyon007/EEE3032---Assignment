function dst=GetMahalanobisDistance(F1, F2, e)

x=F1-F2;
x=x.^2;
x=x./e(:,:);
x=sum(x);
dst=sqrt(x); 

return;