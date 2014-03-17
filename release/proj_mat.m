function [P] = proj_mat()
load rgbd.mat;
[u,v] = meshgrid(1:640, 1:480);
mask = mask == 0;
if sum(mask(:)) > 1000
   R = rand(480, 640) > 1000/sum(mask(:));
   mask(R) = 0;
end

u = u(mask);
v = v(mask);
x = x(mask);
y = y(mask);
z = z(mask);

T = size(x);
A = [x y z ones(T) zeros(T) zeros(T) zeros(T) zeros(T) -u.*x -u.*y, -u.*z -u];
B = [zeros(T) zeros(T) zeros(T) zeros(T) x y z ones(T) -v.*x -v.*y, -v.*z -v]; 
C = [A; B];
[U,S,V] = svd(C);
P = reshape(V(:,12), 4, 3)';
