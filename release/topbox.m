function [box_num] = topbox()
list = load('list.txt');
P = proj_mat();
bw = cell(size(list,1));
textprogressbar('topbox1: ');
for n = 1 : size(list,1) 
  textprogressbar(n/size(list,1)*100);
  cmd = sprintf('load boxparam%d.mat', n);
  eval(cmd);
  bw{n} = proj_region(minx1, miny1, minz1, maxx1, maxy1, maxz1, TR1, P);
  bw{n} = edge(bw{n}, 'canny', 0.1);
  %imshow(bw{n});
  %drawnow;
end

im = imread('color.ppm');
im = im2double(im);
im = rgb2gray(im);
im = edge(im, 'canny', 0.1);
im = bwdist(im, 'euclidean');
textprogressbar('done');

textprogressbar('topbox2: ');
cc = [];
for n = 1 : size(list,1)
   textprogressbar(n/size(list,1)*100);
   cmd = sprintf('load boxparam%d.mat', n);
   eval(cmd);
   T = box_check(minx1, miny1, minz1, maxx1, maxy1, maxz1, TR1);
   %r = abs(length(x11)/((maxx1-minx1)*(maxy1-miny1)*(maxz1-minz1)+0.001)-3.5e5);
   d = im .* bw{n};
   d = sum(d(:))/(sum(sum(bw{n}))+1e-3); 
   if (max(T(3,:)) <= -0.0001 && cost > 0.5) 
     cost = min([rr1,rr2]); %/((maxx1-minx1)*(maxy1-miny1)*(maxz1-minz1));
   else
     cost = 0;
   end
   if (d > 10) 
     cost = 0;
   end
   cc = [cc; cost];
end
textprogressbar('done');

[cst, id] = sort(cc, 'descend');
%cst = cst/max(cst);
cst = 1 - cst/max(cst(:));
save sorted_boxes.mat cst id;
%load rgbd.mat;
%T = rand(size(x(:)), 1) < 0.01; 
%plot3(x(T), y(T), z(T), 'y.');
%hold on;
N = sum(cst < 1);
box_num = min(100,N);
for n = 1 : min(100, N)
  cmd = sprintf('load boxparam%d.mat', id(n));
  eval(cmd);
  plot_pointx(x11, y11, z11, x21, y21, z21);
  hold on;
  plot_box(minx1, miny1, minz1, maxx1, maxy1, maxz1, TR1);
  
  hold on;
end
hold off;
axis equal;
