function out = readtext(varargin)
%ML.Files.readtext Get text file content, line by line
%   TXT = ML.FILES.READTEXT(FNAME) reads the content of the text file FNAME
%   and loads it in the TXT cell vector. Each element of TXT correpond to a
%   line in the source text file.
%
%   TXT = ML.FILES.READTEXT(..., 'blank', true) keep the blank lines, which
%   are removed by default.
%
%   See also .

% === Input variables =====================================================

in = ML.Input;
in.fname = @ischar;
in.blank(false) = @islogical;
in.comment('') = @ischar;
in = +in;

% =========================================================================

% Text file read
fid = fopen(in.fname, 'r');
tmp = textscan(fid, '%s', 'delimiter', '\n');
fclose(fid);

% Output
out = tmp{1};

% Remove blank lines
if ~in.blank
    out(cellfun(@isempty, out)) = [];
end

% Remove blank lines
if ~isempty(in.comment)
    out(cellfun(@(x) strcmp(x(1:numel(in.comment)), in.comment), out)) = [];
end