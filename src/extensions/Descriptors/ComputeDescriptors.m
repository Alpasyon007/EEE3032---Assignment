function ComputeDescriptors(DATASET_FOLDER, DESCRIPTOR_FOLDER, DESCRIPTOR_SUBFOLDER, methodFunc, methodFuncParam)

OUT_FOLDER = DESCRIPTOR_FOLDER;
OUT_SUBFOLDER = DESCRIPTOR_SUBFOLDER;

allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
         fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
%     img = double(imread(imgfname_full));

    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    if exist('methodFuncParam','var')
        F=methodFunc(img, methodFuncParam);
    else
        F=methodFunc(img);
    end
    save(fout,'F');
    toc
end