function pairdist2()
seg = load('seg.txt');
N = max(seg(:));
distmap = zeros(N,size(seg,1), size(seg,2));
textprogressbar('pairdist2: ');
for n = 1 : N
    T = im2double(seg == n);
    T = edge(T, 'canny', 0.1);
    T = bwdist(T, 'Euclidean');
    distmap(n,:,:) = T;
end
%save distmap.mat distmap;
list = [];
for m = 1 : N-1
 textprogressbar(m/(N-1)*100);
 T = squeeze(distmap(m, :, :));
 [y,x] = find(seg == m);
 a1 = min(x); a2 = max(x);
 b1 = min(y); b2 = max(y);
 for n = m+1 : N
    [y,x] = find(seg == n);
    c1 = min(x); c2 = max(x);
    d1 = min(y); d2 = max(y);
    if (min([abs(c1-a1) abs(c2-a1) abs(c1-a2) abs(c2-a2) abs(d1-b1) abs(d2-b1) abs(d1-b2) abs(d2-b2)]) > 40)
          continue;
    end
    eg = squeeze(distmap(n,:,:)) == 0;
    if (min(T(eg)) < 20)
       list = [list; m n];
    end
 end
end
save list.txt list -ascii;     
textprogressbar('done');
