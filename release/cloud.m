function cloud(nnn)
cmd = sprintf('sed -e ''1,10d'' ../../clouddata/home/x%d.ply > my.txt', nnn);
system(cmd);
cmd = sprintf('cp ../../clouddata/home/color%d.png color.png', nnn);
system(cmd);

d = load('my.txt');
r = reshape(d(:,4), 640, 480)/255; r = imrotate(r, -90);
g = reshape(d(:,5), 640, 480)/255; g = imrotate(g, -90);
b = reshape(d(:,6), 640, 480)/255; b = imrotate(b, -90);
im = cat(3, r, g, b);
%im = imrotate(im, -90);
%figure(1);
%imshow(im);

x = reshape(d(:,1), 640, 480); x = imrotate(x, -90);
y = reshape(d(:,2), 640, 480); y = imrotate(y, -90);
z = reshape(d(:,3), 640, 480); z = imrotate(z, -90);
mask = x== 0 & y == 0 & z == 0 & r == 0 & g == 0 & b == 0;

%figure(2);
im = imread('color.png');
%im = imrotate(im, -90);
im = im2double(im);
rr = im(:,:,1); rr = fliplr(rr);
gg = im(:,:,2); gg = fliplr(gg);
bb = im(:,:,3); bb = fliplr(bb);
imm = cat(3, rr, gg, bb);
%imshow(imm);
imwrite(imm, 'color.ppm');

save rgbd.mat x y z r g b mask;

