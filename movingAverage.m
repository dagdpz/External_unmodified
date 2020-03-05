function y = movingAverage(x, w)

% http://matlabtricks.com/post-11/moving-average-by-convolution
% Last update: 20141120 Danial
%%
k = ones(1, w) / w;  % kernel

for g=1:size(x,2)
    % shape:
    % 'full' ...Full convolution (default).
    % 'same' ...Central part of the convolution of the same size as u.
    % 'valid'...Only those parts of the convolution that are computed without the zero-padded edges.
    
    % exapmle:
    % if data=Matrix of 1*10  and  window (kernel) is 1*5
    % full would be 10+5-1=14 elements
    % same would be 10 elments
    % valid would be 10-5+1=6 elements
    
    shape= 'valid';
    if length(x(:,g))>= w
        y(:,g) = conv(x(:,g), k, shape);
    else
        y(:,g) = x(:,g);
    end
end


end