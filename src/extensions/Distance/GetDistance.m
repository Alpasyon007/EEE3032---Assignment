function dst=GetDistance(queryimg, ALLFEAT, methodFunc, methodFuncParam)

NIMG=size(ALLFEAT,1);           % number of images in collection

dst=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryimg,:);
%     thedst=cvpr_compare(query,candidate);
%     thedst=GetEculideanDistance(query, candidate);
%     thedst=GetMahalanobisDistance(query,candidate, ALLFEATPCA);
    if exist('methodFuncParam','var')
        thedst=methodFunc(query, candidate, methodFuncParam);
    else
        thedst=methodFunc(query, candidate);
    end
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results

return;