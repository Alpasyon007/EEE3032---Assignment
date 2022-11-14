function dst=GetDistance(queryimg, ALLFEAT)

NIMG=size(ALLFEAT,1);           % number of images in collection

dst=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryimg,:);
%     thedst=cvpr_compare(query,candidate);
    thedst=GetEculideanDistance(query, candidate);
%     thedst=GetMahalanobisDistance(query,candidate, ALLFEATPCA);
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results

return;