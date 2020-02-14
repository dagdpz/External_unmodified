function pass = scaleinvariance2

% Modification of scaleinvariance.m
% This code makes sure a few things are scale-invariant when the interval
% is split (tests endpoints).
% Rodrigo Platte
% (A Level 1 chebtest)

splitting on

d = [1 2];
scale = 2^100;
fh = @(x) abs(x-1.2)+10;

f = chebfun(fh,d);
maxf = max(f);

f1 = chebfun(@(x) fh(x*scale),d/scale);
pass(1) = (max(f1)==maxf) && all(f1.ends*scale == f.ends);

f2 = chebfun(@(x) fh(x/scale),d*scale);
pass(2) = (max(f2)==maxf) && all(f2.ends/scale == f.ends);

f3 = chebfun(@(x) fh(x)*scale,d);
pass(3) = (max(f3)==maxf*scale) && all(f3.ends == f.ends);

f4 = chebfun(@(x) fh(x)/scale,d);
pass(4) = (max(f4)==maxf/scale) && all(f4.ends == f.ends);


