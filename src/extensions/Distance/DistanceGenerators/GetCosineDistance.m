function dst=GetCosineDistance(F1, F2)
    p=size(F1,2);
    F3 = sqrt(sum(F1.*F1,2)); 
    F1 = F1 ./ F3(:,ones(1,p));
    F4 = sqrt(sum(F2.*F2,2)); 
    F2 = F2 ./ F4(:,ones(1,p));
    dst = 1 - F1*F2';    
return;