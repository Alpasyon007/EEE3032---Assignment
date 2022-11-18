function G=ComputeSpatialGrid(img, rowCol)

% ImageCells = mat2tiles(img, [C,C]);
E = [];
A = [];

% Read in image
grayImage = img;
[rows, columns, ~] = size(grayImage);
% imshow(grayImage);
% axis on;
% impixelinfo
numBandsVertically = rowCol(1);
numBandsHorizontally = rowCol(2);
topRows = round(linspace(1, rows+1, numBandsVertically + 1));
leftColumns = round(linspace(1, columns+1, numBandsHorizontally + 1));

% Draw lines over image
% for k = 1 : length(topRows)
% 	yline(topRows(k), 'Color', 'y', 'LineWidth', 2);
% end
% for k = 1 : length(leftColumns)
% 	xline(leftColumns(k), 'Color', 'y', 'LineWidth', 2);
% end

% Extract into subimages and display on a new figure.
% hFig2 = figure();
% plotCounter = 1;
for row = 1 : length(topRows) - 1
	row1 = topRows(row);
	row2 = topRows(row + 1) - 1;
	for col = 1 : length(leftColumns) - 1
		col1 = leftColumns(col);
		col2 = leftColumns(col + 1) - 1;
%  		subplot(numBandsVertically, numBandsHorizontally, plotCounter);
 		subImage = grayImage(row1 : row2, col1 : col2, :);
%  		imshow(subImage);
        E = [E ComputeEdgeOrientationHistogram(subImage)];
        C = ComputeGlobalColour(subImage);

        % C(1) = Average Red, C(2) = Average Green, C(3) = Average Blue
        A = [A C(1) C(2) C(3)];
%  		caption = sprintf('Rows %d-%d, Columns %d-%d', row1, row2, col1, col2);
%  		title(caption);
%  		drawnow;
% 		plotCounter = plotCounter + 1;
	end
end

G = [E A];
% hFig2.WindowState = 'Maximized';


% for i=1:length(ImageCells)
%     % Use compute global colour function which calculates average colour
%     % for the image but pass in each image cell ultimately calculating the
%     % average colour for each cell
%     C = ComputeGlobalColour(ImageCells{i});
% 
%     % C(1) = Average Red, C(2) = Average Green, C(3) = Average Blue
%     G = [G C(1) C(2) C(3)];
% end
