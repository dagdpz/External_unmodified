function [h p t] = ttest_1n(c,e,tail)

c_m = mean(c);     % mean of the normative sample (1 value per subject)
c_s = std(c);      % standard deviation of the normative sample (1 value per subject)
c_n = numel(c);    % sample size of normative sample 

t=(e-c_m)/(c_s*(sqrt((c_n+1)/c_n)));

if nargin<3 || tail==1 
    p_1 = 1-tcdf(abs(t),c_n-1);
    p = 2*p_1;
else
    p_1 = 1-tcdf(abs(t),c_n-1);
    p = p_1;
end

if p < 0.05
    h=1;
elseif p >= 0.05
    h=0;
else
    h=NaN;
end