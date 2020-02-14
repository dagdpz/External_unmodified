function handles = switchmode(guiObject,handles,newMode,callMode)

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

% Only use callMode when calling from loaddemo_menu - for demos with an initial
% guess / condition, we don't want to clear the figures.
if nargin == 3
    callMode = 'notDemo';
end

if strcmp(newMode,'bvp') % Going into BVP mode
    handles.guifile.type = 'bvp';
    
    set(handles.button_ode,'Value',1)
    set(handles.button_pde,'Value',0)
    set(handles.button_eig,'Value',0)
    
    set(handles.text_DEs,'String','Differential equation(s)')
    set(handles.input_GUESS,'visible','On')
    set(handles.text_initial,'String','Initial guess')
    set(handles.toggle_useLatest,'Visible','on')
    
    set(handles.text_timedomain,'Visible','off')
    set(handles.input_timedomain,'Visible','off')
    
    set(handles.button_realplot,'Visible','off')
    set(handles.button_imagplot,'Visible','off')
    set(handles.button_envelope,'Visible','off')
    set(handles.input_GUESS_cover,'Visible','Off');
    set(handles.toggle_useLatest,'Value',0)
    
    if isempty(fieldnames(handles.latest))
        set(handles.toggle_useLatest,'Enable','off')
    end
    
    set(handles.iter_list,'Visible','off')
    set(handles.iter_list,'String','')
    set(handles.iter_list,'Value',0)
    set(handles.iter_text,'Visible','off')
    set(handles.iter_text,'String','')
    
    set(handles.panel_eigopts,'Visible','Off')
    
    pdeplotopts(handles,0)
    
    % Switch from LBC and RBC fields to BC
    set(handles.input_LBC,'Visible','Off')
    set(handles.text_LBCs,'Visible','Off')
    set(handles.input_RBC,'Visible','Off')
    set(handles.text_RBCs,'Visible','Off')
    set(handles.input_BC,'Visible','On')
    set(handles.text_BCs,'Visible','On')
    
    % Change the list of available options.
    % Enable ODE menu options
    set(handles.menu_odedampednewton,'Enable','On')
    set(handles.menu_odeplotting,'Enable','On')
    % Disable PDE menu options
    set(handles.menu_pdeplotting,'Enable','Off')
    set(handles.menu_pdeholdplot,'Enable','Off')
    set(handles.menu_pdefix,'Enable','Off')
    set(handles.menu_fixN,'Enable','Off')
    
    % Clear the figures
    initialisefigures(handles,callMode)
    
    %     % Load a new random BVP example and change the demos popup menu
    %     handles.guifile = loadexample(handles.guifile,-1,'bvp');
    %     loadfields(handles.guifile,handles)
    
elseif strcmp(newMode,'pde') % Going into PDE mode
    handles.guifile.type = 'pde';
    
    set(handles.button_ode,'Value',0)
    set(handles.button_pde,'Value',1)
    set(handles.button_eig,'Value',0)
    set(handles.toggle_useLatest,'Visible','off')
    set(handles.iter_list,'Visible','off')
    set(handles.iter_text,'Visible','off')
    set(handles.text_initial,'String','Initial condition')
    set(handles.text_DEs,'String','Differential equation(s)')
    
    pdeplotopts(handles,1)
    
    set(handles.input_GUESS,'Visible','On')
    set(handles.input_GUESS,'Enable','On')
    set(handles.input_GUESS_cover,'Visible','Off');
    set(handles.toggle_useLatest,'Value',0)
    set(handles.toggle_useLatest,'Enable','off')
    
    set(handles.text_timedomain,'Visible','on')
    set(handles.input_timedomain,'Visible','on')
    
    set(handles.button_realplot,'Visible','off')
    set(handles.button_imagplot,'Visible','off')
    set(handles.button_envelope,'Visible','off')
    
    set(handles.panel_eigopts,'Visible','Off')
    
    % Switch from BC to LBC and RBC fields
    set(handles.input_LBC,'Visible','On')
    set(handles.text_LBCs,'Visible','On')
    set(handles.input_RBC,'Visible','On')
    set(handles.text_RBCs,'Visible','On')
    set(handles.input_BC,'Visible','Off')
    set(handles.text_BCs,'Visible','Off')
    
    % Change the list of available options
    % Disable ODE menu options
    set(handles.menu_odedampednewton,'Enable','Off')
    set(handles.menu_odeplotting,'Enable','Off')
    % Enable PDE menuoptions
    set(handles.menu_pdeplotting,'Enable','On')
    set(handles.menu_pdeholdplot,'Enable','On')
    set(handles.menu_pdefix,'Enable','On')
    set(handles.menu_fixN,'Enable','On')
    
    % Clear the figures
    initialisefigures(handles,callMode)
    
    %     handles.guifile = loadexample(handles.guifile,-1,'pde');
    %     loadfields(handles.guifile,handles)
    
else % Going into EIG mode
    handles.guifile.type = 'eig';
    
    set(handles.button_ode,'Value',0)
    set(handles.button_pde,'Value',0)
    set(handles.button_eig,'Value',1)
    
    set(handles.toggle_useLatest,'Visible','off')
    set(handles.text_DEs,'String','Differential operator')
    % set(handles.iter_list,'Visible','on')
    % set(handles.iter_text,'Visible','on')
    set(handles.text_initial,'String','Look for')
    set(handles.input_GUESS,'visible','Off')
    set(handles.input_GUESS_cover,'Visible','Off');
    set(handles.toggle_useLatest,'Enable','off')
    
    set(handles.text_timedomain,'Visible','off')
    set(handles.input_timedomain,'Visible','off')
    
    set(handles.button_realplot,'Visible','on')
    set(handles.button_realplot,'Value',1)
    set(handles.button_imagplot,'Visible','on')
    set(handles.button_imagplot,'Value',0)
    set(handles.button_envelope,'Visible','off')
    
    set(handles.panel_eigopts,'Visible','On')
    if ~isempty(handles.guifile.sigma)
        switch handles.guifile.sigma
            case '',   set(handles.popupmenu_sigma,'Value',1);
            case 'lm', set(handles.popupmenu_sigma,'Value',2);
            case 'sm', set(handles.popupmenu_sigma,'Value',3);
            case 'lr', set(handles.popupmenu_sigma,'Value',4);
            case 'sr', set(handles.popupmenu_sigma,'Value',5);
            case 'li', set(handles.popupmenu_sigma,'Value',6);
            case 'si', set(handles.popupmenu_sigma,'Value',7);
        end
    else
        set(handles.popupmenu_sigma,'Value',1)
    end
    if isfield(handles.guifile.options,'numeigs') && ~isempty(handles.guifile.options.numeigs)
        set(handles.edit_eigN,'String',handles.guifile.options.numeigs);
    else
        set(handles.edit_eigN,'String',6);
    end
    
    set(handles.iter_list,'Visible','off')
    set(handles.iter_list,'String','')
    set(handles.iter_list,'Value',0)
    set(handles.iter_text,'Visible','off')
    set(handles.iter_text,'String','')
    
    pdeplotopts(handles,0)
    
        % Switch from LBC and RBC fields to BC
    set(handles.input_LBC,'Visible','Off')
    set(handles.text_LBCs,'Visible','Off')
    set(handles.input_RBC,'Visible','Off')
    set(handles.text_RBCs,'Visible','Off')
    set(handles.input_BC,'Visible','On')
    set(handles.text_BCs,'Visible','On')
    
    % Change the list of available options.
    % Disable ODE options
    set(handles.menu_odedampednewton,'Enable','Off')
    set(handles.menu_odeplotting,'Enable','Off')
    % Disable PDE options
    set(handles.menu_pdeplotting,'Enable','Off')
    set(handles.menu_pdeholdplot,'Enable','Off')
    set(handles.menu_pdefix,'Enable','Off')
    set(handles.menu_fixN,'Enable','Off')
    
    
    % Clear the figures
    initialisefigures(handles,callMode)
    
    
    %     % Load a new random BVP example and change the demos popup menu
    %     handles.guifile = loadexample(handles.guifile,-1,'bvp');
    %     loadfields(handles.guifile,handles)
    
    
end


function pdeplotopts(handles,onoff)
if onoff == 1
    onoff = 'on';
elseif onoff == 0
    onoff = 'off';
end


function initialisefigures(handles,callMode)
if ~strcmpi(callMode,'demo')
    cla(handles.fig_sol,'reset');
    axes(handles.fig_sol);
    title('Solutions'), % axis off
end
cla(handles.fig_norm,'reset');
title('Updates')
