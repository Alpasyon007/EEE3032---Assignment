function dst=cvpr_compare(F1, F2)

% This function should compare F1 to F2 - i.e. compute the distance
% between the two descriptors

% For now it just returns a random number

x=F1-F2;
x=x.^2; 
x=sum(x); 
dst=sqrt(x); 

% dst=rand();

return;
