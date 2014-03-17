function r = rand4(N)
    t = 1 : N;
    for n = 1 : 4
      r = floor(rand(1,1)*(N-n+1)) + n;
      tmp = t(n);
      t(n) = t(r);
      t(r) = tmp;
    end
    r = t(1:4);
