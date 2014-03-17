function [minx, miny, minz, maxx, maxy, maxz, TF, TR, x1, y1, z1, x2, y2, z2, plane1, plane2, rr1, rr2] = get_box3(x, y, z, seg, seg_id1, seg_id2, mask)
S1 = seg == seg_id1;
S2 = seg == seg_id2;

S1(mask) = 0;
S2(mask) = 0;
K = sum(S1(:));
if K > 1000
   R = rand(size(S1(:))) > 1000/K;
   S1(R) = 0;
end
K = sum(S2(:));
if K > 1000
   R = rand(size(S2(:))) > 1000/K;
   S2(R) = 0;
end

xyz = [x(S1), y(S1), z(S1)];
xx1 = x(S1);
yy1 = y(S1);
zz1 = z(S1);
[cidx, ctrs] = kmeans(xyz, 2); %, 'Replicates', 1);
id1 = cidx == 1;
id2 = cidx == 2;
%figure(3); plot3(xyz(id1,1), xyz(id1,2), xyz(id1,3), '.');
%hold on;
%plot3(xyz(id2,1), xyz(id2,2), xyz(id2,3), 'r.');
%%hold off;
xyz1 = xyz; id11 = id1; id21 = id2;
   
xyz = [x(S2), y(S2), z(S2)];
xx2 = x(S2);
yy2 = y(S2);
zz2 = z(S2);
[cidx, ctrs] = kmeans(xyz, 2); %, 'Replicates', 1);
id1 = cidx == 1;
id2 = cidx == 2;
xyz2 = xyz; id12 = id1; id22 = id2;

d1 = min(min(dist2(xyz1(id11,:), xyz1(id21,:))));
d2 = min(min(dist2(xyz2(id12,:), xyz2(id22,:))));
e1a = min(min(dist2(xyz1(id11,:), xyz2)));
e1b = min(min(dist2(xyz1(id21,:), xyz2)));
e2a = min(min(dist2(xyz2(id12,:), xyz1)));
e2b = min(min(dist2(xyz2(id22,:), xyz1)));

if d1 > 0.2 
   if (e1a < e1b)
      xx1 = xyz1(id11,1); yy1 = xyz1(id11,2); zz1 = xyz1(id11,3);
   else
      xx1 = xyz1(id21,1); yy1 = xyz1(id21,2); zz1 = xyz1(id21,3);
   end
end

if d2 > 0.2
   if (e2a < e2b)
      xx2 = xyz2(id12,1); yy2 = xyz2(id12,2); zz2 = xyz2(id12,3);
   else
      xx2 = xyz2(id22,1); yy2 = xyz2(id22,2); zz2 = xyz2(id22,3);
   end
end
   
%figure(3); plot3(xyz(id1,1), xyz(id1,2), xyz(id1,3), 'g.');
%hold on;
%plot3(xyz(id2,1), xyz(id2,2), xyz(id2,3), 'y.');
%hold off;

if (length(xx1) < 4 || length(xx2) < 4)
    x1 = xx1; y1 = yy1; z1 = zz1;
    x2 = xx2; y2 = yy2; z2 = zz2;
    plane1 = [1;1;1;1];
    plane2 = [1;1;1;1];
    minx = 0; maxx = 0; miny = 0; maxy = 0; minz = 0; maxz = 0;
    TR = zeros(4,4); TF = zeros(4,4);
    rr1 = 0; rr2 = 0;
    return;
end

[x1, y1, z1, p1] = ransac_filter(xx1, yy1, zz1);
[x2, y2, z2, p2] = ransac_filter(xx2, yy2, zz2);

plane1 = p1;
plane2 = p2;

u = p1(1); v = p1(2); w = p1(3);
t = sqrt(u^2 + v^2);
Txz = [u/t v/t 0 0; -v/t u/t 0, 0; 0 0 1 0; 0 0 0 1];
h = sqrt(u^2 + v^2 + w^2); 
Tz = [w/h 0 -t/h 0; 0 1 0 0; t/h 0 w/h 0; 0 0 0 1];

P = Tz*Txz*[x1 y1 z1 ones(length(x1), 1)]';
Q = Tz*Txz*[x2 y2 z2 ones(length(x2), 1)]';

%plot3(P(1,:), P(2,:), P(3,:), '.');
%hold on;
%plot3(Q(1,:), Q(2,:), Q(3,:), 'r.');
%hold off;
%axis equal;
%axis vis3d;

xt = Q(1,:); yt = Q(2,:); zt = Q(3,:);
xt(isnan(xt) | isinf(xt)) = rand(1,1);
yt(isnan(yt) | isinf(yt)) = rand(1,1);
zt(isnan(zt) | isinf(zt)) = rand(1,1);

[U,S,V] = svd([xt' yt' zt' ones(length(xt), 1)]);
u = V(1,4); v = V(2,4);
t = sqrt(u^2 + v^2);
Rz = [u/t v/t 0 0; -v/t u/t 0 0; 0 0 1 0; 0 0 0 1];
P = Rz * P;
Q = Rz * Q;
%figure(1);
%plot3(P(1,:), P(2,:), P(3,:), '.');
%hold on;
%plot3(Q(1,:), Q(2,:), Q(3,:), 'r.');
%hold off;
%axis equal;
%axis vis3d;

TF = Rz*Tz*Txz;
TR = inv(Txz)*inv(Tz)*inv(Rz);

numP = length(P(1,:));
[N, X] = hist(P(1,:), 20);
id = find(N > numP/500);
if isempty(id)
   id = find(N >= 0);
end
pminx = min(X(id));
pmaxx = max(X(id));

numP = length(P(2,:));
[N, X] = hist(P(2,:), 20);
id = find(N > numP/500);
if isempty(id)
   id = find(N >= 0);
end
pminy = min(X(id));
pmaxy = max(X(id));

numP = length(Q(2,:));
[N, X] = hist(Q(2,:), 20);
id = find(N > numP/500);
if isempty(id)
   id = find(N >= 0);
end
qminy = min(X(id));
qmaxy = max(X(id));

numP = length(Q(3,:));
[N, X] = hist(Q(3,:), 20);
id = find(N > numP/500);
if isempty(id)
   id = find(N >= 0);
end
qminz = min(X(id));
qmaxz = max(X(id));

pmz = mean(P(3,:));
qmx = mean(Q(1,:));

minx = min(pminx, qmx); maxx = max(pmaxx, qmx);
miny = min(pminy, qminy); maxy = max(pmaxy, qmaxy);
minz = min(pmz, qminz); maxz = max(pmz, qmaxz);

%t = 1-abs(sum(plane1(1:3) .* plane2(1:3)));
rr1 = (pmaxx-pminx)*(pmaxy-pminy)/((maxx-minx)*(maxy-miny)); %*t;
rr2 = (qmaxy-qminy)*(qmaxz-qminz)/((maxy-miny)*(maxz-minz)); %*t;
%rr1 = sum(S1(:))/((maxx-minx)*(maxy-miny));
%rr2 = sum(S2(:))/((maxy-miny)*(maxz-minz));
