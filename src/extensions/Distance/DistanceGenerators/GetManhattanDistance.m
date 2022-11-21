function d=GetManhattanDistance(F1, F2)
    d = sum(abs(bsxfun(@minus,F1,F2)),2);
return;
