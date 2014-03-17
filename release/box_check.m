function [T] = box_check(minx, miny, minz, maxx, maxy, maxz, TR)

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

F = [face1, face2, face3, face4, face5, face6];
F = unique(F', 'rows');
F = F';

T = TR * F;
%plot3( T(1,:), T(2,:), T(3,:), 'r-', 'linewidth', 5);
