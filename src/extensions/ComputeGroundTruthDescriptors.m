function ComputeGroundTruthDescriptors()

DATASET_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\msrc_objcategimagedatabase_v2';
DESCRIPTOR_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\descriptors';

OUT_FOLDER = DESCRIPTOR_FOLDER;
OUT_SUBFOLDER = 'GroundTruth';

allfiles=dir (fullfile([DATASET_FOLDER,'/GroundTruth/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
         fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/GroundTruth/',fname]);
    img=imread(imgfname_full);

    RGBmat = reshape(img,[],3);
    [RGBunq, ~, RGBgroup] = unique(RGBmat,'rows'); 
    nRGB = size(RGBunq,1);

    Legend = {0   0   0   'void';
              128 0   0   'building';
              0   128 0   'grass';
              128 128 0   'tree';
              0   0   128 'cow';
              128 0   128 'horse';
              0   128 128 'sheep';
              128 128 128 'sky';
              64  0   0   'mountain';
              192 0   0   'aeroplane';
              64  128 0   'water';
              192 128 0   'face';
              64  0   128 'car';
              192 0   128 'bicycle';
              64  128 128 'flower';
              192 128 128 'sing';
              0   64  0   'bird';
              128 64  0   'book';
              0   192 0   'chair';
              128 64  128 'road';
              0   192 128 'cat';
              128 64  128 'dog';
              64  64  0   'body';
              192 64  0   'boat';};

    LegendColOne = vertcat(Legend{:, 1});
    LegendColTwo = vertcat(Legend{:, 2});
    LegendColThree = vertcat(Legend{:, 3});

    objectClass = [];

    for i=1:size(LegendColOne, 1)
        for j=1:size(RGBunq, 1)
            if LegendColOne(i, 1) == RGBunq(j, 1) && LegendColTwo(i, 1) == RGBunq(j, 2) && LegendColThree(i, 1) == RGBunq(j, 3)
                objectClass = [objectClass Legend(i, 4)];
            end
        end
    end

    F=[fname objectClass];
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    save(fout,'F');
    toc
end