function MLAB_header = get_header(this)
%[matfile].get_header Get the MLAB header of a matfile.
%   H = [matfile].GET_HEADER() returns the header of a matfile. The header
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
%   If the matfile do not exist, a NaN is returned.
%
%   See also: ML.matfile, ML.matfile.set_header.

% --- Checks
if ~exist(this.full, 'file')
    MLAB_header = NaN;
    return
end

% --- Load
warning off
load(this.full, 'MLAB_header');
warning on

% --- Check MLab header existence
if ~exist('MLAB_header', 'var')
    error('ML:matfile:get_header:NoHeader', 'Could not load the header.');
end

