function N = and(N,bc)
%&   Set boundary conditions for a chebop.
% N = N & BC sets the boundary conditions of N to those described in BC. BC
% may be a structure with fields 'left', 'right', and other', taking
% values as described below; otherwise both boundaries are assigned the
% same conditions. Either way, ALL previous boundary conditions in N are
% replaced.
%
% The 'left', 'right', and 'other' fields, or the entire BC, may be single
% item or a cell array for multiple conditions. Each item imposes a
% condtion on the solution u depending on the item's type, as follows:
%   
%   scalar, r: u = r at the boundary (Dirichlet condition)
%              (valid for 'left' and 'right' fields only).
%
%   keyword, 'dirichlet' or 'neumann': u=0 or u'=0 at the boundary
%            'periodic': periodic boundary coditions
%
%   function, g: g(u) = 0 (when evaluated at boundary for 'left'/'right')
%
% Example:
%
%   N = chebop(@(u) diff(u,4) + sin(u));
%   bc.left = {1,'neumann'};  
%   bc.right = -1; 
%   bc.other = @(u) sum(u);
%   u = (N & bc) \ 0;   % solve a BVP

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

N = set(N,'bc',bc);

end