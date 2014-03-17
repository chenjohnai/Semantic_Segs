function plot_normalized_pointy(x1, y1, z1, T)
P = T*[x1 y1 z1 ones(length(x1), 1)]';
plot3(P(1,:), P(2,:), P(3,:), '.');

