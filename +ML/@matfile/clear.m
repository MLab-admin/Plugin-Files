function clear(this, varargin)
%[matfile].clear Remove variables' content from a matfile.
%   [matfile].CLEAR(VAR1, VAR2, ...) deletes the content of all the 
%   variables passed as arguments and their descriptions in the matfile 
%   object.
%
%   See also: ML.matfile, ML.matfile.infos, ML.matfile.save.

% --- Set header
this.set_header;

% --- Delete variables
M = matfile(this.full, 'Writable', true);

for i = 1:numel(varargin)
    
    M.(varargin{i}) = [];
    
    tmp = M.MLAB_header;
    tmp.description.(varargin{i}) = '';
    M.MLAB_header = tmp;
    
end