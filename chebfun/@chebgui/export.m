function export(guifile,handles,exportType)

% Copyright 2011 by The University of Oxford and The Chebfun Developers. 
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

problemType = guifile.type;
% handles and exportType are empty if user calls export from command window,
% always export to .m file in that case.
if nargin == 1
    exportType = '.m';
end
% Exporting a BVP
if strcmp(problemType,'bvp')
    switch exportType
        case 'GUI'
            prompt = 'Enter the name of the chebgui variable:';
            name   = 'Export GUI';
            numlines = 1;
            defaultanswer='chebg';
            options.Resize='on';
            options.WindowStyle='modal';
            
            answer = inputdlg(prompt,name,numlines,{defaultanswer},options);
            
            if ~isempty(answer)
                assignin('base',answer{1},handles.guifile);
            end
        case 'Workspace'
            numlines = 1;
            options.Resize='on';
            options.WindowStyle='modal';
            
%             if isempty(handles.latest)
%                 % Export only the chebgui object
%                 prompt = {'Chebgui object'};
%                 defaultanswer = {'chebg'};
%                 answer = inputdlg(prompt,name,numlines,defaultanswer,options);
%                 if ~isempty(answer)
%                     assignin('base',answer{1},handles.guifile);
%                 end
%                 return
%             end
                
            varnames = handles.varnames;
            nv = numel(varnames);
            if nv == 1
                prompt = {'Differential operator','Solution:',...
                'Vector with norm of updates', 'Options'};
            else
                prompt = ['Differential operator',varnames.',...
                'Vector with norm of updates', 'Options'];
            end
                    
            name   = 'Export to workspace';
            
            defaultanswer=['N',varnames','normVec','options'];

            
            answer = inputdlg(prompt,name,numlines,defaultanswer,options);
            
            sol = handles.latest.solution;
            if ~isempty(answer)
                assignin('base',answer{1},handles.latest.chebop);
                for k = 1:nv
                    assignin('base',answer{k+1},sol(:,k));
                end
                assignin('base',answer{nv+2},handles.latest.norms);
                assignin('base',answer{nv+3},handles.latest.options);
%                 assignin('base',answer{nv+4},handles.guifile);
            end
        case 'WorkspaceJustVars'                
            varnames = handles.varnames;
            nv = numel(varnames);
            
            sol = handles.latest.solution;
            for k = 1:nv
                assignin('base',varnames{k},sol(:,k));
                evalin('base',varnames{k});
            end
         
        case '.m'            
            [filename, pathname, filterindex] = uiputfile( ...
                {'*.m','M-files (*.m)'; ...
                '*.*',  'All Files (*.*)'}, ...
                'Save as', [problemType,'.m']);
            if filename     % User did not press cancel
                try
                    exportbvp2mfile(guifile,pathname,filename)
                    % Open the new file in the editor
                    open([pathname,filename])
                catch ME
                    error('Chebgui:Export',...
                        'Error in exporting to .m file. Please make sure there are no syntax errors.');
                end
            end
        case '.mat'
            varnames = handles.varnames;
            for k = 1:numel(varnames);
                eval([varnames{k} ' = handles.latest.solution(:,k);']); %#ok<NASGU>
            end
            normVec= handles.latest.norms;  %#ok<NASGU>
            N = handles.latest.chebop;  %#ok<NASGU>
            options = handles.latest.options;  %#ok<NASGU>
            uisave([varnames','normVec','N','options'],'bvp');
        case 'Cancel'
            return;
    end
    
    % Exporting a PDE
elseif strcmp(problemType,'pde')
    switch exportType
        case 'GUI'
            prompt = 'Enter the name of the chebgui variable:';
            name   = 'Export GUI';
            numlines = 1;
            defaultanswer='chebg';
            options.Resize='on';
            options.WindowStyle='modal';
            
            answer = inputdlg(prompt,name,numlines,{defaultanswer},options);
            
            if ~isempty(answer)
                assignin('base',answer{1},handles.guifile);
            end
        case 'Workspace'           
            varnames = handles.varnames;
            nv = numel(varnames);
            if nv == 1
                prompt = {'Solution', 'Time domain', 'Final solution'};
                defaultanswer=  [varnames,'t',[varnames{1} '_final']];
            else
                sol = {}; solfinal = {}; finalsol = {};
                for k = 1:nv
                    sol = [sol ['Solution ' varnames{k}]];
                    finalsol = [finalsol ['Final ' varnames{k}]];
                    solfinal = [solfinal [varnames{k} '_final']];
                end
                prompt = [sol, 'Time domain', finalsol];
                defaultanswer = [varnames','t',solfinal];
            end
            
            name = 'Export to workspace';
            numlines = 1;
            options.Resize='on';
            options.WindowStyle='modal';
            
            answer = inputdlg(prompt,name,numlines,defaultanswer,options);
            sol = handles.latest.solution;
            if ~iscell(sol), sol = {sol}; end
            if ~isempty(answer)
                for k = 1:nv
                    assignin('base',answer{k},sol{k});
                end
                assignin('base',answer{nv+1},handles.latest.solutionT);
                for k = 1:nv
                    assignin('base',answer{nv+1+k},sol{k}(:,end));
                end
%                 msgbox(['Exported chebfun variables named ' answer{1},' and ',...
%                     answer{2}, ' to workspace.'],...
%                     'Chebgui export','modal')
            else
%                 msgbox('Exported variables named u and t to workspace.','Chebgui export','modal')
            end
        case 'WorkspaceJustVars'                
            varnames = handles.varnames;
            nv = numel(varnames);
            sol = handles.latest.solution;
            if ~iscell(sol), sol = {sol}; end
            for k = 1:nv
                assignin('base',varnames{k},sol{k});
                evalin('base',varnames{k});
            end

        case '.m'           
            [filename, pathname, filterindex] = uiputfile( ...
                {'*.m','M-files (*.m)'; ...
                '*.*',  'All Files (*.*)'}, ...
                'Save as', [problemType,'.m']);
            if filename     % User did not press cancel
                try
                    exportpde2mfile(guifile,pathname,filename)
                    % Open the new file in the editor
                    open([pathname,filename])
                catch ME
                    error('Chebgui:Export','Error in exporting to .m file. Please make sure there are no syntax errors.');
                end
            end
        case '.mat'
            varnames = handles.varnames;
            sol = handles.latest.solution;
            if ~iscell(sol), sol = {sol}; end
            for k = 1:numel(varnames);
                eval([varnames{k} ' = sol{k};']); %#ok<NASGU>
            end
%             u = handles.latest.solution; %#ok<NASGU>
            t = handles.latest.solutionT;  %#ok<NASGU>
            uisave([varnames','t'],'pde');
        case 'Cancel'
            return;
    end
else
    switch exportType
        case 'GUI'
            prompt = 'Enter the name of the chebgui variable:';
            name   = 'Export GUI';
            numlines = 1;
            defaultanswer='chebg';
            options.Resize='on';
            options.WindowStyle='modal';
            
            answer = inputdlg(prompt,name,numlines,{defaultanswer},options);
            
            if ~isempty(answer)
                assignin('base',answer{1},handles.guifile);
            end
        case 'Workspace'           
            prompt = {'Eigenvalues', 'Eigenmodes'};
            name   = 'Export to workspace';
            defaultanswer={'D','V'};
            numlines = 1;
            options.Resize='on';
            options.WindowStyle='modal';
            
            answer = inputdlg(prompt,name,numlines,defaultanswer,options);
            
            if ~isempty(answer)
                assignin('base',answer{1},diag(handles.latest.solution));
                assignin('base',answer{2},handles.latest.solutionT);
%                 msgbox(['Exported chebfun variables named ' answer{1},'and ',...
%                     answer{2}, ' to workspace.'],...
%                     'Chebgui export','modal')
            else
%                 msgbox('Exported variables named D and V to workspace.','Chebgui export','modal')
            end
        case 'WorkspaceJustVars'     
            varnames = handles.varnames;
            lambdaName = handles.eigVarName;
            if iscell(lambdaName), lambdaName = lambdaName{:}; end
            nv = numel(varnames);
            d = handles.latest.solution;
            V = handles.latest.solutionT;
            if ~iscell(V), V = {V}; end
            for k = 1:nv
                assignin('base',varnames{k},V{k});
%                 evalin('base',varnames{k});
            end
            assignin('base',lambdaName,d);
            evalin('base',lambdaName);
            
        case '.m'           
            [filename, pathname, filterindex] = uiputfile( ...
                {'*.m','M-files (*.m)'; ...
                '*.*',  'All Files (*.*)'}, ...
                'Save as', 'bvpeig.m');
            if filename     % User did not press cancel
                try
                    exporteig2mfile(guifile,pathname,filename,handles)
                    % Open the new file in the editor
                    open([pathname,filename])
                catch ME
                    error('Chebgui:Export','Error in exporting to .m file. Please make sure there are no syntax errors.');
                end
            end
        case '.mat'
            D = diag(handles.latest.solution); %#ok<NASGU>
            V = handles.latest.solutionT;  %#ok<NASGU>
            uisave({'D','V'},'bvpeig');
        case 'Cancel'
            return;
    end
end
