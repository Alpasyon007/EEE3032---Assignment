function G=ComputeSpatialGrid(img, C)

ImageCells = mat2tiles(img, [C,C]);
G = [];

for i=1:length(ImageCells)
    % Use compute global colour function which calculates average colour
    % for the image but pass in each image cell ultimately calculating the
    % average colour for each cell
    C = ComputeGlobalColour(ImageCells{i});

    % C(1) = Average Red, C(2) = Average Green, C(3) = Average Blue
    G = [G C(1) C(2) C(3)];
end
