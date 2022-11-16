function dst=GetMahalanobisDistance(F1, F2, v)

x=F1-F2;
x=x.^2;
x=x./v';
x=sum(x);
dst=sqrt(x); 

return;