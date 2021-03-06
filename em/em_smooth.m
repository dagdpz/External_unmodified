function s = em_smooth(x,win,n_win)
%em_smooth  - smoothes eye movement data
%
% USAGE:	
% s = em_smooth(x,'rectwin',10);
%
% INPUTS:
%		x		- signal
%		win		- window string (see help window)
%		n_win		- window length
% OUTPUTS:
%		s		- smoothed signal
%
% REQUIRES:	Igtools/clean_convolve
%
% See also em_filter, em_saccade_blink_detection
%
%
% Author(s):	I.Kagan, DAG, DPZ
% URL:		http://www.dpz.eu/dag
%
% Change log:
% 2015-08-07:	Created function (Igor Kagan)
% ...
% $Revision: 1.0 $  $Date: 2015-08-07 17:55:56 $

% ADDITIONAL INFO:
% ...
%%%%%%%%%%%%%%%%%%%%%%%%%[DAG mfile header version 1]%%%%%%%%%%%%%%%%%%%%%%%%% 

kernel = window(win,n_win)';
s = clean_convolve(x,kernel/sum(kernel));