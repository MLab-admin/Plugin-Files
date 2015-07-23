function infos(this)
%[matfile].infos Display informations on matfiles.
%   [matfile].INFOS() displays all the informatins relative to a matfile in
%   the browser window.
%
%   See also: ML.matfile, ML.matfile.exist, ML.matfile.get_header.

% --- Definitions
THF = ML.THF;
THF.css_rule('body {font-size: 0.85em;}');
header = this.get_header;

% --- Checks
if ~isstruct(header) && isnan(header)
    fprintf('This matfile does not exist:\n%s\n\n', this.full);
    return;
end

% --- Display Informations
THF.add(this.name, 'h2');

% --- Header information

THF.add('Header', 'h3');

table = '<table cellspacing=0 cellpadding=5 style=''border-top: 1px solid black; border-left: 1px solid black; font-size: 0.9em;''>';

table = [table line('Full name', this.full)];
table = [table line('Last modification date', header.date)];
table = [table line('Last modification author', header.author)];
table = [table line('Caller file', [header.call_file ' (' num2str(header.call_line) ')'])];
table = [table '</table>'];

THF.add(table);

% --- Content information

table = '<table cellspacing=0 cellpadding=5 style=''border-top: 1px solid black; border-left: 1px solid black; font-size: 0.9em;''>';
table = [table line('th', 'Name', 'Class', 'Size', 'Bytes', 'Description')];

empty = '<table cellspacing=0 cellpadding=5 style=''border-top: 1px solid black; border-left: 1px solid black; font-size: 0.9em;''>';
empty = [empty line('th', 'Name', 'Class', 'Size', 'Bytes', 'Description')];
show_empty = false;

w = whos(matfile(this.full));
for i = 1:numel(w)
    
    % Skip header
    if strcmp(w(i).name, 'MLAB_header'), continue; end
    
    % Description
    if isempty(header.description.(w(i).name))
        desc = '<font style=''color:grey; font-style: italic;''>No description</font>';
    else
        desc = header.description.(w(i).name);
    end
    
    if w(i).bytes
        table = [table line(w(i).name, w(i).class, mat2str(w(i).size), num2str(w(i).bytes), desc)];
    else
        show_empty = true;
        empty = [empty line(w(i).name, w(i).class, mat2str(w(i).size), num2str(w(i).bytes), desc)];
    end
end
table = [table '</table>'];
empty = [empty '</table>'];

THF.add('Variables', 'h3');
THF.add(table);

if show_empty
    THF.add('Empty variables', 'h3');
    THF.add(empty);
end

THF.display;

end

% -------------------------------------------------------------------------
function L = line(varargin)

L = '<tr>';

if strcmp(varargin{1}, 'th')
    tag = 'th';
    varargin(1) = [];
else
    tag = 'td';
end
    
for i = 1:numel(varargin)   
    x = varargin{i};
    if isempty(x), x = '-'; end
    L = [L '<' tag ' style=''border-bottom: 1px solid black; border-right: 1px solid black;''>' x '</' tag '>'];
    tag = 'td';
end

L = [L '</tr>' char(10)];

end