function F=ComputeHarrisFeatures(img, params)  % params is a 2 item array [selectoTopNum gridHalfLength]
   
    F=[];
    A=[];

    grayImg=rgb2gray(img);
    
    corners = detectHarrisFeatures(grayImg,'MinQuality',0.01);
    cornerPoints = corners.selectStrongest(params(1));
    pointLocations = cornerPoints.Location;
    pointLocations = round(pointLocations);

    [x, y, ~] = size(img);

    for i=1:length(pointLocations)

        row1 = bound(pointLocations(i, 2) - params(2), x, 1);
        row2 = bound(pointLocations(i, 2) + params(2), x, 1);
        col1 = bound(pointLocations(i, 1) - params(2), y, 1);
        col2 = bound(pointLocations(i, 1) + params(2), y, 1);

        subImage = img( row1 : row2, col1 : col2, :);
        
        F=[F ComputeEdgeOrientationHistogram(subImage)];
        C = ComputeGlobalColour(subImage);

        % C(1) = Average Red, C(2) = Average Green, C(3) = Average Blue
        A = [A C(1) C(2) C(3)];
    end

    F = [F A];

    % If features are less than requested pad out the rest
    for i=1:(params(1)-length(pointLocations))
        F=[ F [0 0 0 0 0 0 0 0 0 0 0]];
    end

    function out = bound(v, bMax,bMin)
      % return bounded value clipped between bl and bu
      out=max(min(v,bMax),bMin);
    

return;