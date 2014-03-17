im = imread('img_5001.png');
load rgbd.mat;

xx = fill_depth_cross_bfx(im, x3, mask);
yy = fill_depth_cross_bfx(im, y3, mask);
zz = fill_depth_cross_bfx(im, z3, mask);

save xyz_fill.mat xx yy zz;
ximg = (xx-min(xx(:))) ./ (max(xx(:)) - min(xx(:)));
yimg = (yy-min(yy(:))) ./ (max(yy(:)) - min(yy(:)));
zimg = (zz-min(zz(:))) ./ (max(zz(:)) - min(zz(:)));
im = cat(3, ximg, yimg, zimg);
imwrite(im, 'Graph_seg2/images/img_5001.png');


