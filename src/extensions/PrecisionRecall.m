function PrecisionRecall(allfiles, NIMG, dst, SHOW)
    rowCol = [];
    numOfColsPerRow = [];

    row = 1;
    col = 0;

    relevantResultNum = 0;
    totalNumOfResults = 14;
    precision = 0;
    recall = 0;

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
    for i=1:SHOW
        dst(i, 3) = str2num(['uint8(',extractBefore(allfiles(dst(i, 2)).name, "_"),')']);
    end
    
    %
    for i=2:SHOW
        relevantResultNum = relevantResultNum + (dst(1, 3) == dst(i, 3));
    end
    
    precision = relevantResultNum/totalNumOfResults;
    recall = (precision*14)/(numOfColsPerRow(dst(1, 3), 2));

    fprintf('Precision: %f, %d/%d correct out of all returned\n', precision, relevantResultNum, totalNumOfResults);
    fprintf("Recall: %f, Correctly Returned %d/%d from the dataset\n", recall, relevantResultNum, numOfColsPerRow(dst(1, 3), 2));