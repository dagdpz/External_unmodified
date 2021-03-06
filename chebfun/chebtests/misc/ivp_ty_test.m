function pass = ivp_ty_test
% This test solves the Van der Pol ODE in 
% Chebfun using ode15s and ode45. It checks the solution 
% with Matlab's inbuilt ode15s and ode45 solvers

% Rodrigo Platte Jan 2009, modified by Asgeir Birkisson

% Test ode15s Using default tolerances (RelTol = 1e-3)
[t,y] = ode15s(@vdp1,domain(0,5),[2;0]); % chebfun solution
[tm,ym] = ode15s(@vdp1,[0,5],[2;0]); % Matlab's solution

pass(1) = max(max(abs(ym - feval(y,tm)))) < 2e-2;

% Test ode45 Using default tolerances (RelTol = 1e-3)
[t,y] = ode45(@vdp1,domain(0,5),[2;0]); % chebfun solution
[tm,ym] = ode45(@vdp1,[0,5],[2;0]); % Matlab's solution

pass(2) = max(max(abs(ym - feval(y,tm)))) < 1e-2;

% Test with different tolerance
%opts = odeset('RelTol', 1e-6);

% Test ode113
%[t,y] = ode113(@vdp1,domain(0,20),[2;0],opts); % chebfun solution
%[tm,ym] = ode113(@vdp1,[0,20],[2;0],opts); % Matlab's solution
%
%pass(3) = max(max(abs(ym - feval(y,tm)))) < 1e-5;


