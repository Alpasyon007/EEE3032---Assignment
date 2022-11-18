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

[allfiles, ALLFILES, ALLFEAT] = LoadDescriptors(DATASET_FOLDER, DESCRIPTOR_FOLDER, SPATIAL_GRID_FOLDER);

% Build eigen model
figure('Name',"Spatial Grid PCA",'NumberTitle','off')
[eigenBuild, eigenDeflated, ALLFEATPCA] = BuildEigenmodel(ALLFEAT);

% Pick an image at random to be the query
NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image

% queryimg = 323;
% queryimg = 152;
queryimg = 574;

% Get distance between query and candidate images
dst = GetDistance(queryimg, ALLFEAT, @GetEuclideanDistance);
sortDstByImage = sortrows(dst, 2);

img=imread(ALLFILES{sortDstByImage(queryimg,2)});

% ComputeHarrisFeatures(img);

% img=rgb2gray(img);
% 
% corners = detectHarrisFeatures(img);
% figure('Name',"Harris Features",'NumberTitle','off')
% imshow(img); hold on;
% cornerPoint = corners.selectStrongest(1);
% plot(cornerPoint);
% 
% cornerPoint.Location(1) = cornerPoint.Location(1) + 16;
% cornerPoint.Location(2) = cornerPoint.Location(2) + 16;
% 
% plot(cornerPoint);
% 
% cornerPoint.Location(1) = cornerPoint.Location(1) - 32;
% cornerPoint.Location(2) = cornerPoint.Location(2) - 32;
% 
% plot(cornerPoint);

SHOW=15; % Show top 15 results
dst=dst(1:SHOW,:);

% for i=1:SHOW
%      fprintf('image %d/15: %d/%d - %s\n', i, dst(i, 2) ,length(allfiles), allfiles(dst(i, 2)).name);
% end

% Calculate Precision and Recall
[precision, recall] = PrecisionRecall(allfiles, NIMG, dst, SHOW);
% fprintf('Precision: %f\nRecall: %f\n', precision, recall);

outdisplay=[];
for i=1:size(dst,1)
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end

figure('Name','Visual Search','NumberTitle','off')
imshow(outdisplay);
axis off;
