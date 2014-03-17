load rgbd.mat;
seg = load('./segment/out.txt');
%imagesc(seg);
imshow('segment/out.ppm');
%imshow('color.ppm');
[m,n] = ginput(2);
m = floor(m); n = floor(n);
seg_id1 = seg(n(1), m(1));
seg_id2 = seg(n(2), m(2));

[minx1, miny1, minz1, maxx1, maxy1, maxz1, TF1, TR1, x11, y11, z11, x21, y21, z21, plane1, plane2] = get_box2(x, y, z, seg, seg_id1, seg_id2);

%figure(1);
%plot_pointx(x11, y11, z11, x21, y21, z21);
%hold on;
%plot_box(minx1, miny1, minz1, maxx1, maxy1, maxz1, TR1);
%hold on;
%axis equal;

%figure(2);
%plot_normalized_box(minx1, miny1, minz1, maxx1, maxy1, maxz1);
%hold on;
%plot_normalized_pointx(x12, y12, z12, x22, y22, z22, TF1);
%hold on;
%plot_box(minx2, miny2, minz2, maxx2, maxy2, maxz2, TF1*TR2);
%hold on;
u = (maxx1-minx1)/20;
v = (maxy1-miny1)/20;
w = (maxz1-minz1)/20;
[xx,yy,zz] = meshgrid(minx1:u:maxx1, miny1:v:maxy1, minz1:w:maxz1);
plot3(x11(:), y11(:), z11(:), '.r');
hold on;
plot3(x21(:), y21(:), z21(:), '.r');
hold on;
P = TR1*[xx(:) yy(:) zz(:) ones(length(xx(:)), 1)]';
plot3(P(1,:), P(2,:), P(3,:), '.');
hold off;
u = -(plane1(1)*P(1,:) + plane1(2)*P(2,:) + plane1(4))/plane1(3);
v = -(plane2(1)*P(1,:) + plane2(2)*P(2,:) + plane2(4))/plane2(3); 

sum(P(3,:) < u & P(3,:) < v) / 9261 



