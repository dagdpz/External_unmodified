function map = linear(ends)
%LINEARMAP creates a map structure for chebfuns
%   MAP = LINEARMAP(ENDS) returns a structure that defines a linear map. 
%   The structure MAP consists of three function handles and one string.
%   MAP.FOR is a function that maps [-1,1] to ENDS.
%   MAP.INV is the inverse map.
%   MAP.DER is the derivative of the map defined in MAP.FOR
%   MAP.ID is a string that identifies the map.

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

a = ends(1); b = ends(2);
map = struct('for',@(y) b*(y+1)/2+a*(1-y)/2, ...
             'inv',@(x) (x-a)/(b-a)-(b-x)/(b-a), ...
             'der',@(y) (b-a)/2 + 0*y,'name','linear','par', [a b],'inherited',true) ;
    
% Note: writting the map in this form ensures that -1 is mapped to a and 1
% is mapped to b (in the presence of rounding errors).
