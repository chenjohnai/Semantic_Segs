function [I] = proj_region(minx, miny, minz, maxx, maxy, maxz, TR, P)

face1 = [minx minx minx minx minx
         miny miny maxy maxy miny
         minz maxz maxz minz minz
         1    1    1    1    1 ];

face2 = [maxx maxx maxx maxx maxx
         miny miny maxy maxy miny
         minz maxz maxz minz minz
         1    1    1    1    1 ];

face3 = [minx minx maxx maxx minx
         miny maxy maxy miny miny
         minz minz minz minz minz
         1    1    1    1    1 ];

face4 = [minx minx maxx maxx minx
         miny maxy maxy miny miny
         maxz maxz maxz maxz maxz
         1    1    1    1    1 ];

face5 = [minx minx maxx maxx minx
         miny miny miny miny miny
         minz maxz maxz minz minz
         1    1    1    1    1 ];

face6 = [minx minx maxx maxx minx
         maxy maxy maxy maxy maxy
         minz maxz maxz minz minz
         1    1    1    1    1 ];

I = zeros(480, 640);
T = P * TR * face1;
epsi = 1e-6;
xx = T(1,:)./(T(3,:)+epsi);
xx(xx < 1) = 1;
xx(xx > 640) = 640;
yy = T(2,:)./(T(3,:)+epsi);
yy(yy < 1) = 1;
yy(yy > 480) = 480;
xx(isnan(xx) | isinf(xx)) = 1;
yy(isnan(yy) | isinf(yy)) = 1;
bw = roipoly(I, xx, yy);
I = bw | I;

T = P * TR * face2;
xx = T(1,:)./(T(3,:)+epsi);
xx(xx < 1) = 1;
xx(xx > 640) = 640;
yy = T(2,:)./(T(3,:)+epsi);
yy(yy < 1) = 1;
yy(yy > 480) = 480;
xx(isnan(xx) | isinf(xx)) = 1;
yy(isnan(yy) | isinf(yy)) = 1;
bw = roipoly(I, xx, yy);
I = bw | I;

T = P * TR * face3;
xx = T(1,:)./(T(3,:)+epsi);
xx(xx < 1) = 1;
xx(xx > 640) = 640;
yy = T(2,:)./(T(3,:)+epsi);
yy(yy < 1) = 1;
yy(yy > 480) = 480;
xx(isnan(xx) | isinf(xx)) = 1;
yy(isnan(yy) | isinf(yy)) = 1;
bw = roipoly(I, xx, yy);
I = bw | I;

T = P * TR * face4;
xx = T(1,:)./(T(3,:)+epsi);
xx(xx < 1) = 1;
xx(xx > 640) = 640;
yy = T(2,:)./(T(3,:)+epsi);
yy(yy < 1) = 1;
yy(yy > 480) = 480;
xx(isnan(xx) | isinf(xx)) = 1;
yy(isnan(yy) | isinf(yy)) = 1;
bw = roipoly(I, xx, yy);
I = bw | I;

T = P * TR * face5;
xx = T(1,:)./(T(3,:)+epsi);
xx(xx < 1) = 1;
xx(xx > 640) = 640;
yy = T(2,:)./(T(3,:)+epsi);
yy(yy < 1) = 1;
yy(yy > 480) = 480;
xx(isnan(xx) | isinf(xx)) = 1;
yy(isnan(yy) | isinf(yy)) = 1;
bw = roipoly(I, xx, yy);
I = bw | I;

T = P * TR * face6;
xx = T(1,:)./(T(3,:)+epsi);
xx(xx < 1) = 1;
xx(xx > 640) = 640;
yy = T(2,:)./(T(3,:)+epsi);
yy(yy < 1) = 1;
yy(yy > 480) = 480;
xx(isnan(xx) | isinf(xx)) = 1;
yy(isnan(yy) | isinf(yy)) = 1;
bw = roipoly(I, xx, yy);
I = bw | I;

