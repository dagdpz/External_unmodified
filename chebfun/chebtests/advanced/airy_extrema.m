function pass = airy_extrema
% Verifies that the extrema of the airy function on [-15,0] are found
% correctly.
% Rodrigo Platte

f = chebfun('exp(real(airy(x)))',[-15,0]);
r = roots(diff(f));
R =[-14.935937196720515
    -14.111501970462992
    -13.262218961665209
    -12.384788371845742
    -11.475056633480252
    -10.527660396957428
    -9.535449052433554
    -8.488486734019695
    -7.372177255047834
    -6.163307355639518
    -4.820099211178722
    -3.248197582179822
    -1.018792971647486];
pass = norm(r-R,inf) < 500*chebfunpref('eps');
