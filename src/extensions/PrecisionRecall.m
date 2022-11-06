function PrecisionRecall(allfiles, NIMG, dst, SHOW)
    rowCol = [];
    for i=1:NIMG
        rowNum = str2num(['uint8(',extractBefore(allfiles(i).name, "_"),')']);
        colNum = str2num(['uint8(',extractBefore(extractAfter(allfiles(i).name,  rowNum + "_"), "_s"),')']);
    
    %     fprintf("Row num: %d\n", rowNum);
    %     fprintf("Col num: %d\n", colNum);
    
        rowCol = [rowCol ; [rowNum colNum]];
    end
    rowCol = sortrows(rowCol, 1);
    
    row = 1;
    col = 0;
    numOfColsPerRow = [];
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
    
    precisionRelevancy = [];
    recallRelevancy = [];
    
    for i=1:SHOW
        dst(i, 3) = str2num(['uint8(',extractBefore(allfiles(dst(i, 2)).name, "_"),')']);
    end
    
    for i=2:SHOW
        precisionRelevancy(i, 1) = (dst(1, 3) == dst(i, 3));
    end
    
    precision = 0;
    recall = 0;
    
    for i=2:SHOW
        precision = precision + precisionRelevancy(i, 1);
    end
    
    recall = precision/numOfColsPerRow(dst(1, 3), 2);
    fprintf("Recall: %f, Correctly Returned %d/%d from the dataset\n", recall, precision, numOfColsPerRow(dst(1, 3), 2));
    
    precision = precision/14;
    fprintf('Precision: %f, %d/%d correct out of all returned\n', precision, precision*14, 14);