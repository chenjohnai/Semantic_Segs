load rgbd.mat;
seg = load('./segment/out.txt');
%imagesc(seg);
imshow('segment/out.ppm');
[m,n] = ginput(1);
m = floor(m); n = floor(n);
S1 = seg == seg(n(1), m(1));
x = x(S1); 
y = y(S1);
z = z(S1); 
figure(1);
plot3(x, y, z, '.');
N = length(x);
M = 0;
for n = 1 : 50 
   r = rand4(N);
   [U,S,V] = svd([x(r) y(r) z(r) ones(4, 1)]);
   p = V(:,4);
   q = abs([x y z ones(N, 1)] * p);
   L = find(q < 0.01);
   if length(L) > M 
     M = length(L);  
     xx = x(L);
     yy = y(L);
     zz = z(L);
   end 
end
figure(2);
plot3(xx, yy, zz, 'r.');
  
 
    


