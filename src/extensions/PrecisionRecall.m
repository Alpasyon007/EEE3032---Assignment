function [precisionRecallMat, averagePrecision, precision, recall]=PrecisionRecall(allfiles, NIMG, dst, SHOW)
    rowCol = [];
    numOfColsPerRow = [];

    row = 1;
    col = 0;

    relevantResultNum = 0;
    totalNumOfResults = 14;
    precision = 0;
    recall = 0;

    DATASET_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\msrc_objcategimagedatabase_v2';
    DESCRIPTOR_FOLDER = 'C:\Users\Alpas\OneDrive - University of Surrey\EEE3032 - Assignment\descriptors';
  
%     Legend = {'void'        0;
%               'building'    0;
%               'grass'       0;
%               'tree'        0;
%               'cow'         0;
%               'horse'       0;
%               'sheep'       0;
%               'sky'         0;
%               'mountain'    0;
%               'aeroplane'   0;
%               'water'       0;
%               'face'        0;
%               'car'         0;
%               'bicycle'     0;
%               'flower'      0;
%               'sing'        0;
%               'bird'        0;
%               'book'        0;
%               'chair'       0;
%               'road'        0;
%               'cat'         0;
%               'dog'         0;
%               'body'        0;
%               'boat'        0;};
% 
%       ALLFEAT={};
%       ALLFILES=cell(1,0);
%       ctr=1;
%       allGroundTruthFiles=dir(fullfile([DATASET_FOLDER,'/GroundTruth/*.bmp']));
%       for filenum=1:length(allGroundTruthFiles)
%           fname=allGroundTruthFiles(filenum).name;
%           imgfname_full=([DATASET_FOLDER,'/GroundTruth/',fname]);
%           featfile=[DESCRIPTOR_FOLDER,'/','GroundTruth','/',fname(1:end-4),'.mat'];%replace .bmp with .mat
%           load(featfile,'F');
%           ALLFILES{ctr}=imgfname_full;
%           ALLFEAT(filenum, 1)={F};
%           ctr=ctr+1;
%       end
% 
%       for filenum=1:length(allGroundTruthFiles)
%           c = ALLFEAT{filenum};
%           for i=2:length(c)
%               for j=1:length(Legend)
%                   if strcmpi(c(1, i), Legend(j, 1))
%                      Legend{j, 2} = plus(Legend{j, 2}, 1);
%                   end
%               end
%           end
%       end

    for i=1:NIMG
        rowNum = str2num(['uint8(',extractBefore(allfiles(i).name, "_"),')']);
        colNum = str2num(['uint8(',extractBefore(extractAfter(allfiles(i).name,  rowNum + "_"), "_s"),')']);
    
        rowCol = [rowCol ; [rowNum colNum]];
    end
    rowCol = sortrows(rowCol, 1);
    
    for i=1:NIMG
        if row == rowCol(i, 1)
            if rowCol(i, 2) > col
                col = rowCol(i, 2);
                numOfColsPerRow(row, 2) = col;
            end
        else
            col = 0;
        end
    
        numOfColsPerRow(row, 1) = row;
        row = rowCol(i, 1);
    end

    % Row Numbers for Top 15 Results
    for i=1:NIMG
        dst(i, 3) = str2num(['uint8(',extractBefore(allfiles(dst(i, 2)).name, "_"),')']);
    end
    
    precisionRecallMat = [];
    numberOfRelevantResultsInDatabase = numOfColsPerRow(dst(1, 3), 2) - 1;

    for i=2:NIMG
        relevantResultNum = relevantResultNum + (dst(1, 3) == dst(i, 3));
        precisionRecallMat = [precisionRecallMat; relevantResultNum/(i-1) relevantResultNum/numberOfRelevantResultsInDatabase  (dst(1, 3) == dst(i, 3))];
        if relevantResultNum/numberOfRelevantResultsInDatabase == 1
            break;
        end
    end
    
    relevantResultNum = 0; % Reset Releveant Results Number

    for i=2:SHOW
        relevantResultNum = relevantResultNum + (dst(1, 3) == dst(i, 3));
    end

    precisionList = precisionRecallMat(:, 1);
    recallList = precisionRecallMat(:, 3);
    averagePrecision = sum(precisionList.*recallList)/numberOfRelevantResultsInDatabase;

    precision = relevantResultNum/totalNumOfResults;
    recall = relevantResultNum/numberOfRelevantResultsInDatabase;

%     plot(precisionRecallMat(:, 2), precisionRecallMat(:, 1))
%     axis([0 1 0 1])
%     xlabel('Recall');
%     ylabel('Precision');
% 
%     fprintf('Precision: %f, %d/%d correct out of all returned\n', precision, relevantResultNum, totalNumOfResults);
%     fprintf("Recall: %f, %d/%d correctly returned from the dataset\n", recall, relevantResultNum, numberOfRelevantResultsInDatabase);