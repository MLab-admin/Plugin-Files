function save(this, varargin)
%[matfile].save Save variables to a matfile.
%   [matfile].SAVE(VAR, DESC) Saves a variable VAR with description DESC 
%   into the matfile object. The name of VAR in the calling m-file is used 
%   to design the appended variable. If a variable with the same name is 
%   already present  in the matfile, it will be overwriten.
%
%   [matfile].SAVE(NAME, VAR, DESC) Specifies the name of the variable to
%   append to the mat-file.
%
%   See also: ML.matfile, ML.matfile.infos, ML.matfile.clear.

% --- Set header
this.set_header;

% --- Save variable and description
M = matfile(this.full, 'Writable', true);
header = M.MLAB_header;
switch numel(varargin)
    case 2

        M.(inputname(2)) = varargin{1};
        header.description.(inputname(2)) = varargin{2};
        
    case 3
        M.(varargin{1}) = varargin{2};
        header.description.(varargin{1}) = varargin{3};
end
M.MLAB_header = header;