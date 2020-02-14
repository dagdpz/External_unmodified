function [newGUI handles] = cleargui(guifile, handles)

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

% Clear the input fields
set(handles.input_domain,'String','');
set(handles.input_timedomain,'String','');
set(handles.input_DE,'String','');
set(handles.input_DE,'String','');
set(handles.input_LBC,'String','');
set(handles.input_RBC,'String','');
set(handles.input_BC,'String','');
set(handles.input_GUESS,'String','');
set(handles.menu_tolerance,'UserData','1e-10'); % The default tolerance


% Clear the figures
initialisefigures(handles)

% Hide the iteration information
set(handles.iter_list,'String','');
set(handles.iter_text,'Visible','Off');
set(handles.iter_list,'Visible','Off');
% set(handles.text_norm,'Visible','Off');

% Disable export figures
set(handles.button_figsol,'Enable','off');
set(handles.button_fignorm,'Enable','off');
set(handles.button_solve,'Enable','on');
set(handles.button_solve,'String','Solve');

% Enable RHS of BCs again
set(handles.input_LBC,'Enable','on');
set(handles.input_RBC,'Enable','on');

% Reset eigenvalue options
set(handles.edit_eigN,'String','6');
set(handles.popupmenu_sigma,'Value',1)

% We don't have a solution available anymore
handles.hasSolution = 0;
set(handles.button_exportsoln,'Value',0);

% Clear information from the guifile as well
newGUI = chebgui('type',guifile.type);

function initialisefigures(handles)
cla(handles.fig_sol,'reset');
title('Solutions'), box on
cla(handles.fig_norm,'reset');
title('Updates'), box on