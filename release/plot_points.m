function plot_points(x, y, z, seg, seg_id1, seg_id2)
S1 = seg == seg_id1;
S2 = seg == seg_id2;

%[x1, y1, z1, p1] = ransac_filter(x(S1), y(S1), z(S1));
%[x2, y2, z2, p2] = ransac_filter(x(S2), y(S2), z(S2));
x1 = x(S1);
y1 = y(S1);
z1 = z(S1);
x2 = x(S2);
y2 = y(S2);
z2 = z(S2);

plot3(x1, y1, z1, '.');
hold on;
plot3(x2, y2, z2, 'r.');
hold off; 

