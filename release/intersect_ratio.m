function [r] = intersect_ratio(x, y, z, T, minx, miny, minz, maxx, maxy, maxz)
P = T*[x y z ones(length(x), 1)]';
r = sum(P(1,:)>=minx & P(1,:) <= maxx & P(2,:) >= miny & P(2,:) <= maxy & P(3,:) >= minz & P(3,:) <= maxz)/9261;

