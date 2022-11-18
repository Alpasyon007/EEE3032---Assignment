function d=MinkowskiDistance(F1, F2)
    d = sum(abs(x(F1)-y(F2)).^p).^(1/p);
return;