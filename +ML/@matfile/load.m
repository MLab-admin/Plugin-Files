function varargout = load(this, varargin)
%[matfile].load Load variables from a matfile.
%   OUT = [matfile].LOAD(V1, V2, ...) Loads the variables V1, V2, ... from 
%   the matfile object in the struct OUT.
%
%   OUT = [matfile].LOAD() Loads all variables in the matfile object.
%
%   [OUT,DESC] = [matfile].LOAD(..., '-desc') also returns a struct DESC
%   containing the description of each variable.
%
%   See also: ML.matfile, ML.matfile.save, ML.matfile.infos.

if ~numel(varargin)
    
    % === Global load =====================================================
    
    varargout{1} = rmfield(load(this.full), 'MLAB_header');
    if nargout>1
        header = this.get_header;
        varargout{2} = header.description;
    end
    
else
    
    % === Selected Variable load ==========================================
    
    % --- Load variables
    M = matfile(this.full, 'Writable', true);
    
    % --- Initialization
    out = struct();
    header = M.MLAB_header;
    desc = struct;
    
    % --- Determine direct and indirect variables
    tmp = cellfun(@(x) strcmp(x(1),'#'), varargin);
    I = find(tmp);
    J = find(~tmp);
    
    % --- Load indirect variables first
    for i = 1:numel(J)
        out.(varargin{J(i)}) = M.(varargin{J(i)});
        desc.(varargin{J(i)}) = header.description.(varargin{J(i)});
        varargout{1} = out;
    end
        
    % --- Load direct variables
    for i = 1:numel(I)
        if isempty(J) & i==1
            varargout{1} = M.(varargin{I(i)}(2:end));
        else
            varargout{end+1} = M.(varargin{I(i)}(2:end));
        end
        desc.(varargin{I(i)}(2:end)) = header.description.(varargin{I(i)}(2:end));
    end
    
    % --- Append variable descriptions
    varargout{end+1} = desc;
    
end