function plot_normalized_box(minx, miny, minz, maxx, maxy, maxz)

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

T = face1;
plot3( T(1,:), T(2,:), T(3,:), 'r-', 'linewidth', 5);
hold on;

T = face2;
plot3( T(1,:), T(2,:), T(3,:), 'g-', 'linewidth', 5);

T = face3;
plot3( T(1,:), T(2,:), T(3,:), 'b-', 'linewidth', 5);

T = face4;
plot3( T(1,:), T(2,:), T(3,:), 'c-', 'linewidth', 5);

T = face5;
plot3( T(1,:), T(2,:), T(3,:), 'y-', 'linewidth', 5);

T = face6;
plot3( T(1,:), T(2,:), T(3,:), 'm-', 'linewidth', 5);

hold off;
