function H=ComputeEdgeOrientationHistogram(img)

grayImg = rgb2gray(img);

[Gmag, Gdir] = imgradient(grayImg);

Gdir = Gdir+180;
Gdir = Gdir/360;

Q=4;

bin = Gdir;
vals=reshape(bin,1,size(bin,1)*size(bin,2));
H = hist(vals,8);
H = H ./sum(H);