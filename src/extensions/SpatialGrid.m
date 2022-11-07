function G=SpatialGrid(img, C)

ImageCells = mat2tiles(img, [C,C]);
G = [];

for i=1:length(ImageCells)
    currentCell = ImageCells{i};
    redChannel = currentCell(:, :, 1);
    greenChannel = currentCell(:, :, 2);
    blueChannel = currentCell(:, :, 3);
    % Get means
    meanR = mean(redChannel);
    meanG = mean(greenChannel);
    meanB = mean(blueChannel);

    G = [G meanR meanG meanB];
end
