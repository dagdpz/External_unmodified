function [varagout] = process_varargin(the_keys,default_values,new_varargin)
%
%  take keys, default values and user inputs and build a set
%  of variables in the callng program
%
%  inputs:
%      the_keys        cell array of keys 
%      default_values  default value for each key
%      new_varargin        user inputs to override the defaults
%
%  outputs:
%      creates the_keys variables in the calling program
%      with either the default values or the overrides set
%      optionally will return the_keys and data as a structure
%      if the user supplies a output argument
%
%  NOTE: does no error checking before writing variables
%
%  example implementation:
%----------------------------------------------------------
%   the_keys                = {'filename'};
%   default_values          = {'abc.txt'};
%
%   the_keys{end + 1}       = 'a_vector';
%   default_values{end + 1} =  [0 1 2 3];
%
%   process_varargin(the_keys,default_values,new_varargin{:});
%----------------------------------------------------------
%
%  c.harper (03/31/2010) initial creation (v 1.2)
%                        simplified the multiple argument processing
%  c.harper (04/01/2010) updated code to correctly return strings
%  c.harper (04/15/2010) updated to handle null strings as default values
%  c.harper (07/18/2011) added example implementation to help
%  c.harper (07/21/2011) removed ability to create structure (did not work)
%

   tmp = [];

   n_key = length(the_keys);
   n_def = length(default_values);

%  make sure we have the correct number

   if (n_def ~= n_key)
      fprintf(2,'process_varargin: # of keys ~= # of default values %3d %3d\n',n_key,n_def);
      error('default values error');
   end

%  set up the default values

   for i=1:length(the_keys)
      dyn_var = char(the_keys{i});

      if (isempty(default_values{i}))
         tmp.(dyn_var) = [];
      else
         tmp.(dyn_var) = default_values{i};
      end
   end

%  user overrides ?

   nvar = length(new_varargin);

   i = 1;
   j = 2;
   while (i < nvar)
      ids = find(cellfun(@isempty,strfind(the_keys,new_varargin{i})) == 0);
      if (isempty(ids))
         fprintf(2,'found no key: %s\n',new_varargin{i});
      else
         dyn_var       = char(new_varargin{i});
         tmp.(dyn_var) = new_varargin{j};
      end
      i = i + 2;
      j = j + 2;
   end

%  take the data structure created and assign the values in the
%  calling function (logic from b.goodson)

   names   = fieldnames(tmp);
   values  = struct2cell(tmp);

%    for i=1:length(names)
%       assignin('caller',names{i},values{i});
%    end

   if (nargout > 0)
      varagout = tmp;
   end
end
