for nnn = 1 %1 : 1449
nnn=1;
cmd = sprintf('load testimage/img_5001.mat');
image = imread('testimage/img_5001.png');
r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);

eval(cmd);
z3 = -z3;
[x,y] = size(z3);
k = find(z3 == 0);
mask = zeros(x,y);
mask(k) = 1;
mask = logical(mask);

save rgbd.mat x3 y3 z3 r g b 
% cmd = sprintf('cp testimage/color%d.ppm color.ppm', nnn);
% system(cmd);

fillhole2;
normal2;
cd segment
system('sh go.sh');
cd ..
process_seg;
pairdist2;
localcost;
box_num = topbox; %topbox_svm2;
pairwisecost2(box_num);
pairwiseoverlap2(box_num);
showresult_proj(box_num);
end


