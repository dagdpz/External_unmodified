function [coeffs,poles,k] = residue(u,v,k)
% RESIDUE   Partial-fraction expansion (residues).
%
% [R,P,K] = RESIDUE(B,A) finds the residues, poles and direct term of
% a partial fraction expansion of the ratio of two chebfuns B(s)/A(s).
% If there are no multiple roots,
%        B(s)       R(1)       R(2)             R(n)
%        ----  =  -------- + -------- + ... + -------- + K(s)
%        A(s)     s - P(1)   s - P(2)         s - P(n)
% B and A are chebfuns consisting of a single fun.  The residues are
% returned in the column vector R, the pole locations in column vector
% P, and the direct terms in chebfun K.  The number of poles is n =
% length(A)-1 = length(R) = length(P). The direct term chebfun is zero
% if length(B) < length(A), otherwise length(K) = length(B)-length(A)+1.
%  
% If P(j) = ... = P(j+m-1) is a pole of multplicity m, then the expansion 
% includes terms of the form
%                  R(j)        R(j+1)                R(j+m-1)
%                -------- + ------------   + ... + ------------
%                s - P(j)   (s - P(j))^2           (s - P(j))^m
%  
% [B,A] = RESIDUE(R,P,K), with 3 input arguments and 2 output arguments,
% converts the partial fraction expansion back to the polynomials with
% chebfun representation in B and A.
%  
% Warning: Numerically, the partial fraction expansion of a ratio of
% polynomials represents an ill-posed problem.  If the denominator
% polynomial, A(s), is near a polynomial with multiple roots, then
% small changes in the data, including roundoff errors, can make
% arbitrarily large changes in the resulting poles and residues.
% Problem formulations making use of state-space or zero-pole 
% representations are preferable.

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

if (nargin == 2),
  if (u.nfuns > 1) || (v.nfuns > 1), error('CHEBFUN:residue:multiple_funs',...
      'Residue does not support chebfuns consisting of multiple funs.'); end
  if any(get(u,'exps')) || any(get(v,'exps')), error('CHEBFUN:residue:inf',...
      'Residue does not support functions with nonzero exponents.'); end
  b = poly(u); a = poly(v);
  [coeffs,poles,k] = residue(b,a);
  k = chebfun(@(x) polyval(k,x),length(k),'vectorize');
elseif (nargin == 3),
  if (k.nfuns > 1), error('CHEBFUN:residue:multiple_funs',...
      'Residue does not support chebfuns consisting of multiple funs.'); end
  if any(get(k,'exps')), error('CHEBFUN:residue:inf',...
      'Residue does not support functions with nonzero exponents.'); end
  k = poly(k);
  [b,a] = residue(u,v,k);
  coeffs = chebfun(@(x) polyval(b,x),length(b),'vectorize');
  poles = chebfun(@(x) polyval(a,x),length(a),'vectorize');
else
  error('CHEBFUN:residue:arguments','Residue requires either 2 or 3 arguments.');
end
