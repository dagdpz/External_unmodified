function pass = cftest
% Test CF approximation in various ways.
%
% Nick Trefethen & Joris Van Deun, 4 December 2009

f = chebfun('exp(x)');
[p,q,r,lam] = cf(f,2);
pass(1) = (abs(lam-0.045017)<1e-4);

f = chebfun('exp(-1+x/2)',[0 4]);
[p,q,r,lam] = cf(f,2);
pass(2) = (abs(lam-0.045017)<1e-4);

x = chebfun(@(x) x, [-1 1]);
f = cos(x);
[p,q] = cf(f,1,1);
pass(3) = abs(p(.3)-.77015046914)<1e-4;

f = abs(x);
[p,q] = cf(f,4,4,100);
pass(4) = (norm(f-p./q) < .05);

f = exp(exp(x));
[p,q,r] = cf(f,0,10);
xx = linspace(-1,1,17);
pass(5) = (norm(f(xx)-r(xx)) < 1e-4);


