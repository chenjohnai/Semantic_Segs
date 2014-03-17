function pairwisecost2(box_num)
load sorted_boxes.mat;
p_cost = [];
N = box_num;
textprogressbar('pairwisecost2: ');
for n = 1 : N 
  textprogressbar(100*n/N);
  cmd = sprintf('load boxparam%d.mat', id(n));
  eval(cmd);
  minx2 = minx1;
  miny2 = miny1;
  minz2 = minz1;
  maxx2 = maxx1;
  maxy2 = maxy1;
  maxz2 = maxz1;
  TF2 = TF1;
  TR2 = TR1;
  x12 = x11;
  y12 = y11;
  z12 = z11;
  x22 = z21;
  y22 = y21;
  z22 = z21;
  for m = 1 : N
    if m == n 
       continue;
    end
    cmd = sprintf('load boxparam%d.mat', id(m));
    eval(cmd);

    u = (maxx2-minx2)/20;
    v = (maxy2-miny2)/20;
    w = (maxz2-minz2)/20;
    [xx,yy,zz] = meshgrid(minx2:u:maxx2, miny2:v:maxy2, minz2:w:maxz2);
    r = intersect_ratio(xx(:), yy(:), zz(:), TF1*TR2, minx1, miny1, minz1, maxx1, maxy1, maxz1);
    if (r > 0) 
      p_cost = [p_cost; n m r];
    end
 end   
end
save p_cost_raw.txt p_cost -ascii;


cc = load('p_cost_raw.txt');
p_cost = [];
for n = 1 : N-1 
 for m = n + 1 : N
     id = find((cc(:,1) == n & cc(:,2) == m) | (cc(:,1) == m & cc(:,2) == n)); 
     if ~isempty(id)
        p_cost = [p_cost; n, m, max(cc(id, 3))];
     end
 end
end
save p_cost.txt p_cost -ascii; 
textprogressbar('done');    
