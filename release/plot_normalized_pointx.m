function plot_points(x1, y1, z1, x2, y2, z2, TF)

P = TF*[x1 y1 z1 ones(length(x1), 1)]';
Q = TF*[x2 y2 z2 ones(length(x2), 1)]';

plot3(P(1,:), P(2,:), P(3,:), '.');
hold on;
plot3(Q(1,:), Q(2,:), Q(3,:), 'r.');
hold off;

