function L = recdir(d, varargin)
%ML.Files.recdir Recursive directory exploration
%   ML.FILES.RECDIR(D) get recursively the elements of the directory d.
%
%   See also dir.

%TO DO: update help

% === Input variables =====================================================

in = ML.Input(d, varargin{:});
in.addRequired('d', @ischar);
in.addParamValue('ext', {}, @(x) ischar(x) || iscellstr(x));
in.addParamValue('exclude', {'.', '..', 'private'}, @iscellstr);
in.addParamValue('ignore', {}, @(x) ischar(x) || iscellstr(x));
in.addParamValue('tree', false, @islogical);
in = +in;

% =========================================================================

% --- Conversions
if ischar(in.ext), in.ext = {in.ext}; end
if ischar(in.ignore), in.ignore= {in.ignore}; end

if ~strcmp(in.d(end), filesep), in.d = [in.d filesep]; end
for i = 1:numel(in.ext)
    if ~strcmp(in.ext{i}(1), '.'), in.ext{i} = ['.' in.ext{i}(1)]; end
end
for i = 1:numel(in.ignore)
    if ~strcmp(in.ignore{i}(end), filesep), in.ignore{i} = [in.ignore{i} filesep]; end
end

% --- Declarations
L = [];

% --- Checks
if ~exist(in.d, 'dir'), return; end

tmp = dir(in.d);
for i = 1:numel(tmp)
    
    % Check
    if ismember(tmp(i).name, {'.', '..', 'private'}), continue; end
    
    % Agglomeration
    if tmp(i).isdir
        if ~ismember([in.d tmp(i).name filesep], in.ignore)
            if in.tree
                elm = rmfield(tmp(i), 'isdir');
                elm.children = ML.recdir([in.d tmp(i).name], varargin{:});
                elm.path = in.d;
                L = [L elm];
            else
                L = [L ML.recdir([in.d tmp(i).name], varargin{:})];
            end
        end
    else
        
        % Check extension
        if ~isempty(in.ext)
            [~, ~, ext] = fileparts(tmp(i).name);
            if ~ismember(ext, in.ext), continue; end
        end
        
        elm = rmfield(tmp(i), 'isdir');
        elm.children = [];
        elm.path = in.d;
        L = [L elm];
        
    end
end

