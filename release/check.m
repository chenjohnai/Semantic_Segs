load rgbd.mat;
seg = load('seg.txt');
%imagesc(seg);
%imshow('segment/out.ppm');
im = imread('color.ppm');
im = im2double(im);
list = load('list.txt');
for n = 1000 : length(list)
    R = im(:,:,1);
    G = im(:,:,2);
    B = im(:,:,3);

    R(seg == list(n,1)) = 1;
    B(seg == list(n,2)) = 1;
    imshow(cat(3, R, G, B));
    drawnow;
    ginput(1);
end 
    




