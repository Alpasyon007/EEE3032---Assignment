function dst=GetEuclideanDistance(F1, F2)

    x=F1-F2;
    xSprt=x.^2;
    xSprtSummed=sum(xSprt); 
    dst=sqrt(xSprtSummed); 

return;