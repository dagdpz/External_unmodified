function f = fov(A)
%FOV  Field of values (numerical range) of matrix A
%   F = FOV(A), where A is a square matrix, returns a chebfun F
%   with domain [0 2*pi].  The image F([0 pi]) will be a curve
%   describing the boundary of the field of values A, a convex
%   region in the complex plane.  If A is hermitian, the field of
%   values is a real interval, and if A is normal, it is the
%   convex hull of the eigenvalues of A.
%  
%   EXAMPLE.
%   A = randn(5);
%   F = fov(A);
%   hold off, fill(real(F),imag(F),[1 .5 .5]), axis equal
%   e = eig(A);
%   hold on, plot(real(e),imag(e),'.k','markersize',16)
%
%   The numerical abscissa of A is equal to max(real(F)),
%   though much better computed as max(real(eig(A+A')))/2
%
%   The algorithm use is that of C. R. Johnson, Numerical
%   determination of the field of values of a general complex
%   matrix, SIAM J. Numer. Anal. 15 (1978), 595-602.

%   Copyright 2011 by The University of Oxford and The Chebfun Developers. 
%   See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

f = chebfun(@(theta) z(theta,A),[0, 2*pi],'splitting','on');

function z = z(theta,A)                  
   z = NaN(size(theta));
   for j = 1:length(theta)
      r = exp(1i*theta(j));
      B = r*A;
      H = (B+B')/2;
      [X,D] = eig(H);
      [lam,k] = max(diag(D));
      v = X(:,k);
      z(j) = v'*A*v/(v'*v);
   end
end

end

