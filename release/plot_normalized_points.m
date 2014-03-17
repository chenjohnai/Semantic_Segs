function plot_points(x, y, z, seg, seg_id1, seg_id2, TF)
S1 = seg == seg_id1;
S2 = seg == seg_id2;

x1 = x(S1);
y1 = y(S1);
z1 = z(S1);
x2 = x(S2);
y2 = y(S2);
z2 = z(S2);

P = TF*[x1 y1 z1 ones(length(x1), 1)]';
Q = TF*[x2 y2 z2 ones(length(x2), 1)]';

plot3(P(1,:), P(2,:), P(3,:), '.');
hold on;
plot3(Q(1,:), Q(2,:), Q(3,:), 'r.');
hold off;

