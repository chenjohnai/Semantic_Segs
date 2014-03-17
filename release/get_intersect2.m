load rgbd.mat;
seg = load('./segment/out.txt');
%imagesc(seg);
imshow('segment/out.ppm');
%imshow('color.ppm');
[m,n] = ginput(2);
m = floor(m); n = floor(n);
seg_id1 = seg(n(1), m(1));
seg_id2 = seg(n(2), m(2));

[m,n] = ginput(2);
m = floor(m); n = floor(n);
seg_id3 = seg(n(1), m(1));
seg_id4 = seg(n(2), m(2));

[minx1, miny1, minz1, maxx1, maxy1, maxz1, TF1, TR1, x11, y11, z11, x21, y21, z21, pl11, pl12, rr11, rr12] = get_box3(x, y, z, seg, seg_id1, seg_id2, mask);
[minx2, miny2, minz2, maxx2, maxy2, maxz2, TF2, TR2, x12, y12, z12, x22, y22, z22, pl11, pl12, rr21, rr22] = get_box3(x, y, z, seg, seg_id3, seg_id4, mask);

figure(1);
plot_pointx(x11, y11, z11, x21, y21, z21);
hold on;
plot_box(minx1, miny1, minz1, maxx1, maxy1, maxz1, TR1);
hold on;
plot_pointx(x12, y12, z12, x22, y22, z22);
hold on;
plot_box(minx2, miny2, minz2, maxx2, maxy2, maxz2, TR2);
hold off;
axis equal;

figure(2);
plot_normalized_box(minx1, miny1, minz1, maxx1, maxy1, maxz1);
hold on;
%plot_normalized_pointx(x12, y12, z12, x22, y22, z22, TF1);
%hold on;
plot_box(minx2, miny2, minz2, maxx2, maxy2, maxz2, TF1*TR2);
hold on;
u = (maxx2-minx2)/50;
v = (maxy2-miny2)/50;
w = (maxz2-minz2)/50;
[xx,yy,zz] = meshgrid(minx2:u:maxx2, miny2:v:maxy2, minz2:w:maxz2);
plot_normalized_pointy(xx(:), yy(:), zz(:), TF1*TR2);
hold off;
r = intersect_ratio(xx(:), yy(:), zz(:), TF1*TR2, minx1, miny1, minz1, maxx1, maxy1, maxz1)
axis equal;



