function varargout = chebtune(f,d)
% CHEBTUNE   Chebfun or quasi-matrix melody player.
% 
% CHEBTUNE(F) plays melodies with varying pitch corresponding to the real
% part of the function values of each chebfun in F. The function value 0
% is associated with the tone c'' and the integers below and above
% correspond to the semi-tones. The melodies are separated in the stereo
% panorama.
%
% CHEBTUNE(F,D) plays the melody for D seconds. The default value is D = 2.
%
% Example: Chebpoly-phony
%      f = 7*chebpoly(0:2)-7;
%      f = [ f , f + .2 ];  % add some chorus
%      chebtune(f,3);
%
% Example: Police car
%      x = chebfun('x');
%      chebtune([9+6*sin(46*x),7+10*sin(4*x)],5);
%
% Example: Can you hear the shape of a Chebfun?
%      f = chebfun(12*rand(6,1)-6);
%      chebtune(f,6);
%      plot(f);
%
% See also sound.

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

    if nargin < 2,
        d = 2;
    end
    d = max(d,.5);
    Fc = 22050;          % sound sampling rate
    df = 75;             % chebfun sampling divisor
    dom = domain(f); 
    dom = dom.ends;
    t = linspace(min(dom),max(dom),d*Fc/df).';
    s = real(feval(f,t));           % sample
    s(abs(s)>60|isnan(s)) = -Inf;   % silence
    tone0 = 523.25;                 % c''
    s = tone0*2.^(s/12);            % note to freq
    s = kron(s,ones(df,1));         % upsampling
    s = .5*sin(2*pi*cumsum(s)/Fc);  % freq to waveform
    ch = size(s,2);                 % nr of channels
    % fade in and out to remove blub
    fl = 500;
    fade = repmat(linspace(1,0,fl).',1,ch);
    s(1:fl,:) = s(1:fl,:).*fade(end:-1:1,:);
    s(end+1-fl:end,:) = s(end+1-fl:end,:).*fade;
    s = [ s ; zeros(5000,ch)];
    if ch > 1,
        chv = linspace(0.1,.9,ch)'; 
        chv = chv/sum(chv);
        s = s*[chv,chv(end:-1:1)];
    else
        s = [ s , s ];
    end
    %sound(s,Fc); % this function is using playblocking
    
    % Use the java audio player to play back our sound.
    if usejava('jvm')
        try
            persistent ap
            ap = audioplayer(s, Fc);
            play(ap);
        catch exception
            throw(exception);
        end
    else
        warning('MATLAB:sound:unsupportedoption', ...
            'This platform does not support specifing FS or BITS when not using Java.');
    end

    if nargout > 0, varargout(1) = {s}; end
    if nargout > 1, varargout(2) = {Fc}; end
end