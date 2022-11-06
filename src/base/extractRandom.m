function F=extractRandom(img)

% red=img(:,:,1);
% red=reshape(red,1,[]);
% average_red=mean(red); 
% F=[average_red average_green average_blue]; 

F=ComputeRGBHistogram(img, 4);

% F=rand(1,30);

% Returns a row [rand rand .... rand] representing an image descriptor
% computed from image 'img'

% Note img is a normalised RGB image i.e. colours range [0,1] not [0,255].

return;