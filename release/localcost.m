function localcost()
load rgbd.mat;
seg = load('seg.txt');

pairs = load('list.txt');
pairs = floor(pairs);
textprogressbar('localcost: ');
len = size(pairs, 1);
for n = 1 : len
   textprogressbar(n/len*100);
   [minx1, miny1, minz1, maxx1, maxy1, maxz1, TF1, TR1, x11, y11, z11, x21, y21, z21, plane1, plane2, rr1, rr2] = get_box3(x, y, z, seg, pairs(n,1), pairs(n,2), mask);
   u = (maxx1-minx1)/20;
   v = (maxy1-miny1)/20;
   w = (maxz1-minz1)/20;
   [xx,yy,zz] = meshgrid(minx1:u:maxx1, miny1:v:maxy1, minz1:w:maxz1);
   P = TR1*[xx(:) yy(:) zz(:) ones(length(xx(:)), 1)]';
   u = -(plane1(1)*P(1,:) + plane1(2)*P(2,:) + plane1(4))/plane1(3);
   v = -(plane2(1)*P(1,:) + plane2(2)*P(2,:) + plane2(4))/plane2(3); 
   
   if max(abs(plane1(1:2)))/abs(plane1(3)) > 80
     cost = sum(P(3,:) < v) / 9261;             
   elseif max(abs(plane2(1:2)))/abs(plane2(3)) > 80
     cost = sum(P(3,:) < u) / 9261;
   else
     cost = sum(P(3,:) < u & P(3,:) < v) / 9261;
   end

   cmd = sprintf('save boxparam%d.mat minx1 miny1 minz1 maxx1 maxy1 maxz1 TF1 TR1 x11 y11 z11 x21 y21 z21 plane1 plane2 cost rr1 rr2', n);
   eval(cmd); 
end
textprogressbar('done');

