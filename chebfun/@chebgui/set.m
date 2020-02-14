function cg = set(cg,propName,val)
% SET   Set chebgui properties.
%
%    'type' - 'bvp','pde','eig'
%    'domain' - spatial domain of BVP/PDE
%    'timedomain' - time domain of PDE
%    'de' - the differential operator or RHS F in u_t = F(x,t,u)
%    'lbc' - left boundary conditions
%    'rbc' - right boundary conditions
%    'bc' - general boundary conditions
%    'tol' - tolerance
%    'init' - intial condition/guess for nonlinear BVPs/PDEs
%    'sigma' - desired eigenvalues: 'LM','SM','LA','SA','LR','SR','LI','SI'
%    'options' - a structure containing the below
%      'numeigs' - number of desired eigenvalues
%      'damping' - damping in newton iteration [true/false]
%      'plotting' - plotting in nonlinear solves/PDEs [true/false]
%      'grid' - display a grid on these plots [true/false]
%      'pdeholdplot' - 
%      'fixn' - fixed spatial discretisation for PDEs (experimental)
%      'fixyaxislower' - fix y axis on plots (lower)
%      'fixyaxisupper' - fix y axis on plots (upper)


% Copyright 2011 by The University of Oxford and The Chebfun Developers.
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

% Avoid storing {''} in fields, rather store ''
if iscell(val) && isempty(val{1}), val = ''; end
% Store strings, not numbers.
if isnumeric(val), val = num2str(val); end

switch lower(propName)
    case 'type'
        if ~any(strcmpi(val,{'bvp','ivp','pde','eig'}))
            error('CHEBGUI:set:type',...
                [val,' is not a valid type of problem.'])
        elseif strcmpi(val,'ivp')
            warning('CHEBGUI:set:type',...
                'Type of problem changed from IVP to BVP');
            cg.type = 'bvp';
        else
            cg.type = val;
        end
    case 'domain'
        cg.domain = val;
    case 'timedomain'
        cg.timedomain = val;
    case 'de'
        cg.DE = val;
    case 'lbc'
        cg.LBC = val;
    case 'rbc'
        cg.RBC = val;
    case 'bc'
        cg.BC = val;
    case 'tol'
        cg.tol = val;
    case 'init'
        cg.init = val;
    case 'sigma'
        cg.sigma = val;
    case 'options'
        cg.options = val;
    case 'damping'
        cg.options.damping = val;
    case 'plotting'
        if isnumeric(val)
      val = num2str(val);
        end
        cg.options.plotting = val;
    case 'grid'
        cg.options.grid = val;
    case 'pdeholdplot'
        cg.options.pdeholdplot = val;
    case 'fixn'
        cg.options.fixN = val;
    case 'fixyaxislower'
        cg.options.fixYaxisLower = val;
    case 'fixyaxisupper'
        cg.options.fixYaxisUpper = val;
    case 'numeigs'
        cg.options.numeigs = val;
    otherwise
        error('CHEBGUI:set:propname',...
      [propName,' is not a valid chebgui property.'])
end
