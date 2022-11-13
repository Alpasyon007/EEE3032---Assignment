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

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\msrc_objcategimagedatabase_v2';

%% Folder that holds the results...
DESCRIPTOR_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\descriptors';
%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER='globalRGBhisto';


%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)

ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    ctr=ctr+1;
end

ALLFEAT = ALLFEAT';

eigenBuild=Eigen_Build(ALLFEAT);
MahDist = Eigen_Mahalanobis(ALLFEAT, eigenBuild);
eigenDeflated=Eigen_Deflate(eigenBuild, "keepn", 3);
ALLFEATPCA=Eigen_Project(ALLFEAT, eigenDeflated)';
size(ALLFEATPCA)

figure('Name','PCA','NumberTitle','off')
figure(1);
plot3(ALLFEATPCA(:,1),ALLFEATPCA(:,2),ALLFEATPCA(:,3),'bx');
xlabel('eigenvector1');
ylabel('eigenvector2');
zlabel('eigenvector3');

ALLFEAT = ALLFEAT';

%% 2) Pick an image at random to be the query
NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image
queryimg = 323;

%% 3) Compute the distance of image to the query
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

%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=15; % Show top 15 results
dst=dst(1:SHOW,:);
for i=1:SHOW
    fprintf('image %d/15: %d/%d - %s\n', i, dst(i, 2) ,length(allfiles), allfiles(dst(i, 2)).name);
end

PrecisionRecall(allfiles, NIMG, dst, SHOW);
outdisplay=[];
for i=1:size(dst,1)
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end

figure('Name','Visual Search','NumberTitle','off')
figure(2);
imshow(outdisplay);
axis off;
