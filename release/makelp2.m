function makelp2(N)
load sorted_boxes.mat;
p_cost = load('p_cost.txt');
o_cost = load('overlap_cost.txt');
box_patch = load('list.txt');
box_patch = box_patch(id(1:N), :);
seg = load('seg.txt');

area = [];
for n = 1 : size(box_patch,1) 
    area = [area; sum(sum(seg == box_patch(n,1))) + sum(sum(seg == box_patch(n,2)))];
end
area = area / max(area);
area_box = area;
sp = unique(box_patch(:));
area = [];
for n = 1 : length(sp) 
    area = [area; sum(sum(seg == sp(n)))];
end
area = area / max(area);


fd = fopen('test.lp', 'wt');
fprintf(fd, 'Minimize\n');

for n = 1 : N
    %if cst(n) > 0
      fprintf(fd, '+ %f xx%d\n', 5*cst(n), n);
    %else
    %  fprintf(fd, '%f xx%d\n', cst(n), n);
    %end      
end

%for n = 1 : size(p_cost,1)
%    fprintf(fd, '+ %f zz%d,%d\n', 1*p_cost(n,3), p_cost(n,1), p_cost(n,2));
%end

%for n = 1 : size(o_cost,1)
%    fprintf(fd, '+ %f w%d,%d\n',  0*o_cost(n,3), o_cost(n,1), o_cost(n,2));
%end

for n = 1 : length(sp)
    fprintf(fd, '- %f yy%d\n', 10*area(n), sp(n));
end


fprintf(fd, 'Subject To\n');

for n = 1 : size(p_cost,1)
    fprintf(fd, 'zz%d,%d - xx%d <= 0 \n', p_cost(n,1), p_cost(n,2), p_cost(n,1));
    fprintf(fd, 'zz%d,%d - xx%d <= 0 \n', p_cost(n,1), p_cost(n,2), p_cost(n,2));
    fprintf(fd, 'zz%d,%d - xx%d - xx%d >= -1 \n', p_cost(n,1), p_cost(n,2), p_cost(n,1), p_cost(n,2));
end

%for n = 1 : size(o_cost,1)
%    fprintf(fd, 'w%d,%d - xx%d <= 0 \n', o_cost(n,1), o_cost(n,2), o_cost(n,1));
%    fprintf(fd, 'w%d,%d - xx%d <= 0 \n', o_cost(n,1), o_cost(n,2), o_cost(n,2));
%    fprintf(fd, 'w%d,%d - xx%d - xx%d >= -1 \n', o_cost(n,1), o_cost(n,2), o_cost(n,1), o_cost(n,2));
%end

for n = 1 : length(sp)
   L = find(box_patch(:,1) == sp(n) | box_patch(:,2) == sp(n));
   for m = 1 : length(L)
       fprintf(fd, '+ xx%d\n', L(m));
   end
   fprintf(fd, '- yy%d >=0 \n', sp(n));
end

for n = 1 : length(sp)
   fprintf(fd, 'yy%d <= 1 \n', sp(n));
end

for n = 1 : size(p_cost,1)
    if p_cost(n,3) > 0.05
     fprintf(fd, 'xx%d + xx%d <= 1 \n', p_cost(n,1), p_cost(n,2));
    end
end

%for n = 1 : size(o_cost,1)
%    if o_cost(n,3) > 0.5
%     fprintf(fd, 'xx%d + xx%d <= 1 \n', floor(o_cost(n,1)), floor(o_cost(n,2)));
%    end
%end

fprintf(fd, 'Binaries\n');
for n = 1 : N
  fprintf(fd, 'xx%d\n', n);
end

fprintf(fd, 'End');
fclose(fd);
  



