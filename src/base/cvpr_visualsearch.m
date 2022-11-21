%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

DATASET_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\msrc_objcategimagedatabase_v2';
DESCRIPTOR_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\descriptors';

GLOBAL_AVERAGE_RGB_FOLDER='globalRGBaverage';
GLOBAL_RGB_HISTOGRAM_FOLDER='globalRGBhisto';
SPATIAL_GRID_FOLDER='spatialGrid';
EDGE_ORIENTATION='edgeOrientation';
HARRIS_FEATURES='harrisFeatures';

[allfiles, ALLFILES, ALLFEAT] = LoadDescriptors(DATASET_FOLDER, DESCRIPTOR_FOLDER, HARRIS_FEATURES);

% Build eigen model
[eigenBuild, eigenDeflated, ALLFEATPCA] = BuildEigenmodel(ALLFEAT);
figure('Name',"Spatial Grid PCA",'NumberTitle','off')
plot3(ALLFEATPCA(:,1),ALLFEATPCA(:,2),ALLFEATPCA(:,3),'bx');
xlabel('eigenvector1');
ylabel('eigenvector2');
zlabel('eigenvector3');

% Pick an image at random to be the query
NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image

% queryimg = 323;
% queryimg = 152;
% queryimg = 574;

% Get distance between query and candidate images
% dst = GetDistance(queryimg, ALLFEAT, @GetEuclideanDistance);
RANGE=100;
NCLUSTERS=5;
SPREAD=5;
NPOINTS=100;
DIMENSION=3; 

alldata = ALLFEATPCA';

fprintf('Running KMeans over %d points (of dimension %d)\n',size(alldata,2),DIMENSION);
startingcentres=rand(NCLUSTERS,DIMENSION);
centres=Kmeans(startingcentres,alldata',zeros(1,14));
plot(centres(:,1),centres(:,2),'c*');

% 5) Make a nearest neighbour assignment
alldists=[];
for n=1:NCLUSTERS
   % compute distance of allpoints to this cluster 
   dst=alldata-repmat(centres(n,:)',1,size(alldata,2));
   dst=sqrt(sum(dst.^2));    
   alldists=[alldists;dst];
end
mindists=min(alldists);
alldists=double(alldists==repmat(mindists,NCLUSTERS,1));
for n=1:NCLUSTERS
   alldists(n,:)=alldists(n,:).*n; 
end
classification=max(alldists);

% 6) Plot the assignments
figure;
title('Clustered data after KMeans/KNN');
cla; hold on; 
axis ([-RANGE RANGE -RANGE RANGE]);
ctr=1;

colours=rand(NCLUSTERS,3);
for n=1:size(alldata,2)
    h=plot(alldata(1,n),alldata(2,n),'x');
    set(h,'color',colours(classification(n),:));
end

SHOW=15; % Show top 15 results

TotalPrecision = 0;
TotalRecall = 0;

tic;
for i=1:NIMG
    % Get distance between query and candidate images
    dst = GetDistance(i, ALLFEAT, @GetEuclideanDistance);

    [precisionRecallMat, precision, recall] = PrecisionRecall(allfiles, NIMG, dst, SHOW);

    TotalPrecision = plus(TotalPrecision, precision);
    TotalRecall = plus(TotalRecall, recall);
end
toc;
fprintf('Precision: %f\nRecall: %f\n', TotalPrecision/NIMG, TotalRecall/NIMG);

% % Calculate Precision and Recall
% [precisionRecallMat, precision, recall] = PrecisionRecall(allfiles, NIMG, dst, SHOW);
% fprintf('Precision: %f\nRecall: %f\n', precision, recall);
% 
% dst=dst(1:SHOW,:);
% 
% % for i=1:SHOW
% %      fprintf('image %d/15: %d/%d - %s\n', i, dst(i, 2) ,length(allfiles), allfiles(dst(i, 2)).name);
% % end
% 
% outdisplay=[];
% for i=1:size(dst,1)
%    img=imread(ALLFILES{dst(i,2)});
%    img=img(1:2:end,1:2:end,:); % make image a quarter size
%    img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
%    outdisplay=[outdisplay img];
% end
% 
% figure('Name','Visual Search','NumberTitle','off')
% imshow(outdisplay);
% axis off;
