load xyz_fill.mat;

x = xx; y = yy; z = zz;
M = 13;
hx = imfilter(x, ones(M,M), 'replicate');
hy = imfilter(y, ones(M,M), 'replicate');
hz = imfilter(z, ones(M,M), 'replicate');
hx = imfilter(hx, [-1 0 1], 'replicate');
hy = imfilter(hy, [-1 0 1], 'replicate');
hz = imfilter(hz, [-1 0 1], 'replicate');
hh = [hx(:), hy(:), hz(:)];

vx = imfilter(x, ones(M,M), 'replicate');
vy = imfilter(y, ones(M,M), 'replicate');
vz = imfilter(z, ones(M,M), 'replicate');
vx = imfilter(vx, [-1 0 1]', 'replicate');
vy = imfilter(vy, [-1 0 1]', 'replicate');
vz = imfilter(vz, [-1 0 1]', 'replicate');
vv = [vx(:), vy(:), vz(:)];

rr = cross(hh, vv);
h = size(xx, 1);
w = size(xx, 2);
a = reshape(rr(:,1), h, w);
b = reshape(rr(:,2), h, w);
c = reshape(rr(:,3), h, w);
s = sqrt(a.*a + b.*b + c.*c + 1e-6);
a = a./s;
b = b./s;
c = c./s;

a = (a + 1)/2;
b = (b + 1)/2;
c = (c + 1)/2;

%figure(1); imagesc(a);
%figure(2); imagesc(b);
%figure(3); imagesc(c);
nm = cat(3, a, b, c);
imwrite(nm, 'normal.ppm');
imshow(nm);


