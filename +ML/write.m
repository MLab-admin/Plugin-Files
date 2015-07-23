function out = write(varargin)
%ML.Files.write Writes text into file.
%   ML.FILES.WRITE(FNAME, TXT) writes the content of the TXT cell vector 
%   into the text file FNAME. Each element of TXT correpond to a line in 
%   the output text file.
%
%   STATUS = ML.FILES.WRITE(...) returns a boolean indicating if the
%   writing operation was successful.
%
%   See also ML.Files.read.

% === Input variables =====================================================

in = ML.Input(varargin{:});
in.addRequired('fname', @ischar);
in.addRequired('text', @(x) ismember(class(x), {'char', 'cell'}));
in = +in;

% =========================================================================

% --- Write text to file
fid = fopen(in.fname, 'w');
if ischar(in.text)
    fprintf(fid, '%s', in.text);
elseif iscell(in.text)
    for i = 1:numel(in.text)-1
        fprintf(fid, '%s\n', in.text{i});
    end
    fprintf(fid, '%s', in.text{end});
end
fclose(fid);

% --- Output
out = true;