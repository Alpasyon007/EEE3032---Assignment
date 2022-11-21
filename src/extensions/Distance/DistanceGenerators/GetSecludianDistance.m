function dst=GetSecludianDistance(F1, F2)

dst = 0.5*(std(F1-F2)^2) / (std(F1)^2+std(F2)^2);

return;