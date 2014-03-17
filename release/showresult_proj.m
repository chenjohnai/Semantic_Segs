function showresult_proj(box_num)
load sorted_boxes.mat;
N = box_num;
makelp2(N);
system('~/glpk/bin/glpsol --lp test.lp -o out.txt');
system('sh parse.sh');
res = load('result.txt');
load sorted_boxes.mat;
P = proj_mat();
figure(1);
imshow('color.ppm');
hold on;
for n = 1 : N
  if res(n,2) == 0 
     continue;
  end
  cmd = sprintf('load boxparam%d.mat', id(n));
  eval(cmd);
  plot_proj_box2(minx1, miny1, minz1, maxx1, maxy1, maxz1, TR1, P);
  hold on;
end
  

