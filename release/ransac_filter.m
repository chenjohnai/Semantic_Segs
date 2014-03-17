function [xx, yy, zz, normal] = ransac_filter(x, y, z)
N = length(x);
M = 0;
e = 1e10;
K = length(x);
%if K > 5000
%   R = rand(K,1) < 5000/K;
%   x = x(R);
%   y = y(R);
%   z = z(R);
%end
%K = length(x);

for n = 1 : 200 
   r = rand4(K);
   [U,S,V] = svd([x(r) y(r) z(r) ones(4, 1)]);
   p = V(:,4);
   q = abs([x y z ones(K, 1)] * p);
   L = find(q < 0.01);
   err = sum(q);
   if length(L) > M && err < e 
     M = length(L);  
     e = err;
     xx = x(L);
     yy = y(L);
     zz = z(L);
     normal = p;
   end 
end
