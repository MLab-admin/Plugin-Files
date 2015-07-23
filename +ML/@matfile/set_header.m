function set_header(this)
%[matfile].set_header Set the MLAB header for matfiles.
%   [matfile].SET_HEADER() sets the header of a matfile. The header
%   is a struct with fields:
%       - date:         Date of last modification
%       - author:       Author who performed the last modification
%       - call_file:    Program from which the last modification has been
%                       performed.
%       - call_line:    Line in the program from which the last 
%                       modification has been performed.
%       - description:  Structure containing a description of each
%                       variable.
%
%   See also: ML.matfile, ML.matfile.get_header.

% --- Gather information
config = ML.Config.get;
[call_file, call_line] =  ML.Files.whocalled;

% --- Produce header
MLAB_header = struct('date', datestr(clock), ...
                     'author', config.user.name, ...
                     'call_file', call_file, ...
                     'call_line', call_line, ...
                     'description', struct());
                 
% --- Save header
if ~exist(this.full, 'file')
    
    % Check directory existence
    if ~exist(this.path, 'dir')
       mkdir(this.path) ;
    end
    
    save(this.full, 'MLAB_header');
    
else
    
    % Keep previous descriptions
    tmp = load(this.full, 'MLAB_header');
    MLAB_header.description = tmp.MLAB_header.description;
    
    save(this.full, 'MLAB_header', '-append');
end