function pairwiseoverlap2(box_num)
load sorted_boxes.mat;
P = proj_mat(); % projective matrix
N = box_num;
bw = cell(N);
dp = cell(N);
textprogressbar('pairwiseoverlap2: ');
for n = 1 : N
  textprogressbar(n/N*100);
  cmd = sprintf('load boxparam%d.mat', id(n));
  eval(cmd);
  bw{n} = proj_region(minx1, miny1, minz1, maxx1, maxy1, maxz1, TR1, P);
  dp{n} = (minz1 + maxz1)/2;
end

p_cost = [];
for n = 1 : N 
  for m = 1 : N
    if m == n 
       continue;
    end
    if dp{m} >= dp{n}
      r = sum(sum(bw{m} & bw{n})) / sum(sum(bw{m}));
    else
      r = sum(sum(bw{m} & bw{n})) / sum(sum(bw{n}));
    end      
    if (r > 0)
      p_cost = [p_cost; n m r];
    end
 end   
end
save overlap_raw.txt p_cost -ascii;

cc = load('overlap_raw.txt');
p_cost = [];
for n = 1 : N-1 
 for m = n + 1 : N
     id = find((cc(:,1) == n & cc(:,2) == m) | (cc(:,1) == m & cc(:,2) == n)); 
     if ~isempty(id)
        p_cost = [p_cost; n, m, max(cc(id, 3))];
     end
 end
end
save overlap_cost.txt p_cost -ascii; 
textprogressbar('done');    
