load rgbd.mat;
seg = load('./segment/out.txt');
ids = unique(seg);
N = length(ids);
map = zeros(size(seg));
k = 1;
textprogressbar('process_seg: ');
for n = 1 : N
    textprogressbar(n/N*100);
    T = seg == ids(n);    
    %imx = edge(T, 'canny', 0.1);
    %a = sum(imx(:));
    %b = sum(T(:));
    %r = a.^2/b;

    if (mean(mask(T)) < 0.5) % && r < 100)
       map(T) = k;
       k = k + 1;
    end
end
save seg.txt map -ascii
textprogressbar('done');
