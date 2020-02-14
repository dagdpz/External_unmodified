function handles = solveGUI(guifile,handles)
% SOLVEGUI Called when a user hits the solve button of the chebfun GUI

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

% Check whether some input is missing
if isempty(guifile.domain)
    error('Chebgui:EmptyDomain','The domain must be defined.');
end
if isempty(guifile.DE)
    error('Chebgui:EmptyDE','The differential equation can not be empty.');
end
if isempty(guifile.LBC) && isempty(guifile.RBC) && isempty(guifile.BC)
    error('Chebgui:EmptyBC','Boundary conditions must be defined.');
end

if strcmp(get(handles.button_solve,'string'),'Solve')   % In solve mode
    
    % Some basic checking of the inputs.
    dom = guifile.domain;
    a = dom(1); b = dom(end);
    if b <= a
        error('Chebgui:IncorrectDomain','Error in constructing domain. %s is not valid.',dom);
    end
    tol = guifile.tol;
    if ~isempty(tol)
        tolnum = str2num(tol);
        if isnan(tolnum) || isinf(tolnum) || isempty(tolnum)
            error('Chebgui:InvalidTolerance','Invalid tolerance, ''%s''.',tol);
        end
    end   
    if strcmpi(guifile.type,'pde');
        tt = str2num(guifile.timedomain);
        if isempty(tt)
            error('Chebgui:IncorrectTimeInterval','Error in constructing time interval.');
        end
        if isempty(guifile.init)
            error('Chebgui:EmptyInitialCondition','Initial condition is empty.');
        end
        if str2num(tol) < 1e-6
            tolchk = questdlg('WARNING: PDE solves in chebgui are limited to a tolerance of 1e-6', ...
                         'WARNING','Continue', 'Cancel','Continue');
            if strcmp(tolchk,'Continue')
                tol = '1e-6';
                guifile.tol = tol;
                handles.guifile.tol = tol;
            else
                return
            end
        end
    elseif get(handles.button_eig,'Value')
        newString = handles.guifile.sigma;
    end
    
    % Disable buttons, figures, etc.
    set(handles.toggle_useLatest,'Enable','off');
    set(handles.button_exportsoln,'Enable','off');
    set(handles.button_figsol,'Enable','off');
    set(handles.button_fignorm,'Enable','off');
    if ~get(handles.button_eig,'Value') % STOP and PAUSE don't work in EIGS mode.
        % Pause button
    %     set(handles.button_clear,'Enable','off');
        set(handles.button_clear,'String','Pause');
        set(handles.button_clear,'BackgroundColor',[255 179 0]/256);
        % Stop button
        set(handles.button_solve,'String','Stop');
        set(handles.button_solve,'BackgroundColor',[214 80 80]/256);
    end
    drawnow
    set(handles.menu_demos,'Enable','off');
    % Call the private method solveguibvp, pde, or eig which do the work
    try
        if strcmpi(handles.guifile.type,'bvp')
            handles = solveguibvp(guifile,handles);
        elseif strcmpi(handles.guifile.type,'pde')
            handles = solveguipde(guifile,handles);
        else
            handles = solveguieig(guifile,handles);            
        end
        handles.hasSolution = 1;
    catch ME
        Mstruct = struct('identifier',ME.identifier,'message',ME.message,'stack',ME.stack);
        MEID = ME.identifier;
        % For specific common errors, update the error information before
        % rethrowing an error.
        if strcmp(MEID,'LINOP:mldivide:NoConverge')
            Mstruct.identifier = ['Chebgui:' Mstruct.identifier];
            Mstruct.message = [Mstruct.message, ' See "help cheboppref" for details ',...
                'how to increase number of points.'];
        elseif ~isempty(strfind(MEID,'Parse:')) || ~isempty(strfind(MEID,'LINOP:')) ...
                ||~isempty(strfind(MEID,'Lexer:')) || ~isempty(strfind(MEID,'Chebgui:'))
            Mstruct.identifier = ['Chebgui:' Mstruct.identifier];
        elseif strcmp(MEID,'CHEBOP:solve:findguess:DivisionByZeroChebfun')
            Mstruct.identifier = ['Chebgui:' Mstruct.identifier];
            Mstruct.message =  ['Error in constructing initial guess. The zero '...
                'function on the domain is not a permitted initial guess '...
                'as it causes division by zero. Please assign an initial '...
                'guess using the initial guess field.'];
        else
            handles.hasSolution = 0;
            rethrow(ME);
            
        end
        error(Mstruct)

    end
    resetComponents(handles);
    set(handles.toggle_useLatest,'Enable','on');
    set(handles.button_exportsoln,'Enable','on');
else   % In stop mode
    set(handles.button_clear,'String','Clear all');
    set(handles.button_clear,'BackgroundColor',get(handles.button_export,'BackgroundColor'));
    set(handles.button_solve,'String','Solve');
    set(handles.button_solve,'BackgroundColor',[43 129 86]/256);
    set(handles.menu_demos,'Enable','on');
    set(handles.button_exportsoln,'Enable','off');
    handles.hasSolution = 1;
    drawnow
end

function resetComponents(handles)
% Enable buttons, figures, etc. Set button to 'solve' again
set(handles.button_solve,'String','Solve');
set(handles.button_solve,'BackgroundColor',[43 129 86]/256);
set(handles.button_clear,'String','Clear all');
set(handles.button_clear,'BackgroundColor',get(handles.button_export,'BackgroundColor'));
set(handles.button_figsol,'Enable','on');
set(handles.button_fignorm,'Enable','on');
set(handles.button_exportsoln,'Enable','off');
set(handles.menu_demos,'Enable','on');

function msg = cleanErrorMsg(msg)
errUsingLoc = strfind(msg,sprintf('Error using'));
if errUsingLoc
    % Trim everything before this
    msg = msg(errUsingLoc:end);
    % Look for first two line breaks (char(10))
    idx = find(msg==char(10),1);
    % Take only what's after the 2nd
    msg = msg(idx+1:end);
end
