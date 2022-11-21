function d=GetMinkowskiDistance(F1, F2, p)
    d = sum(abs(F1-F2).^p).^(1/p);
return;