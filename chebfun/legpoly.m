function p = legpoly(n,d,normalize,method)
% LEGPOLY   Legendre polynomials.
%   P = LEGPOLY(N) computes a chebfun of the Legendre polynomial of degree
%   N on the interval [-1,1]. N can be a vector of integers.
%
%   P = LEGPOLY(N,D) computes the Legendre polynomials as above, but on the
%   interval given by the domain D, which must be bounded.
%
%   P = LEGPOLY(N,D,'norm') or P = LEGPOLY(N,'norm') normalises so that 
%   integrate(P(:,j).*P(:,k)) = delta_{j,k}.
%
%   For N <= 1000 LEGPOLY uses a weighted QR factorisation of a 2*(N+1) x
%   2*(N+1) Chebyshev Vandemonde matrix. For N > 1000 it uses the standard
%   recurrence relation. This default can be overwritten by passing a
%   fourth input LEGPOLY(N,D,NORM,METHOD), where METHOD is 1 or 2
%   respectively.
%
% See also chebfun/legpoly, chebpoly, and legpts.

% Copyright 2011 by The University of Oxford and The Chebfun Lvelopers.
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

% Parse input
if isempty(n), p = chebfun; return; end
if nargin < 2 || isempty(d), d = [-1,1]; end
if nargin < 3, normalize = 0; end
if isa(d,'char'), normalize = d; d = [-1,1]; end
if isa(d,'domain'), d = d.ends; end
if isempty(normalize), normalize = 0; end
if strncmp(normalize,'norm',4), normalize = 1;
elseif ischar(normalize), normalize = 0; end
    
% Unbounded domains aren't supported/defined
if any(isinf(d))
    error('CHEBFUN:legpoly:infdomain', ...
        'Legendre polynomials are not defined over an unbounded domain.');
end

nmax = max(n);
N = nmax + 1;

% Determine which method
if nargin == 4
    % Method has been passed as an input
elseif nmax > 1000
    % Use three-term recurrence (possible loss of orthogonality)
    method = 1;
else
    % Use QR orthogonalization of Chebyshev polynomials for moderate nmax
    method = 2;
end

switch method
    case 1 % Recurrence
        
        [aa,bb,cc] = unique(n);  %#ok<ASGLU>
        P = zeros(N,length(n));  % Initialise storage
        x = chebpts(N);          % Chebyshev points
        L0 = ones(N,1); L1 = x;  % P_0 and P_1
        ind = 1;                 % Initialise counter
        for k = 2:nmax+2,        % The recurrence relation (k = degree)
            if aa(ind) == k-2   
                if normalize
                    invnrm = sqrt((2*k-3)/diff(d));
                    P(:,ind) = L0*invnrm;
                else
                    P(:,ind) = L0;
                end
                ind = ind + 1;
            end
            [L0, L1] = deal(L1, ((2*k-1)/k)*x.*L1 - ((k-1)/k)*L0);
        end
        p = chebfun(P(:,cc),d);  % Convert the discrete values to chebfuns
    
    case 2 % QR

        pts = 2*N;               % Expand on Chebyshev grid of twice the size
        [x, w] = chebpts(pts);   % Grab the Clenshaw-Curtis weights
        theta = pi*(pts-1:-1:0)'/(pts-1);
        A = cos(theta*(0:nmax)); % Vandemonde-type matrix
        D = spdiags(sqrt(w(:)),0,pts,pts); % C-C quad weights
        Dinv = spdiags(1./sqrt(w(:)),0,pts,pts);
        [Q, R] = qr(D*A,0);      % Weighted QR
        P = Dinv*Q;
        if normalize
            PP = P(:,n+1)*diag(sqrt(2/diff(d))*sign(P(end,n+1)));
        else
            PP = P(:,n+1)*diag(1./P(end,n+1));
        end
        p = chebfun(PP,d);       % Convert discrete values into chebfuns

end

% Ensure P_n has length n+1
if numel(n) > 1
    p = simplify(p,1e-10,2,1);   % Final valid coeff will be O(1) anyway
end

% Adjust orientation
if size(n,1) > 1, p = p.'; end

