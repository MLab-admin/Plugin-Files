classdef matfile<handle
%matfile is the mat-files handling class.
    
    % --- PROPERTIES ------------------------------------------------------
    properties
        
        full = '';
        path = '';
        name = '';
        
    end
    
    % --- METHODS ---------------------------------------------------------
    methods
        
        % _________________________________________________________________
        function this = matfile(filename)
        %matfile::constructor
            
            % --- Definitions
            this.full = filename;
            [this.path, this.name] = fileparts(filename);
            
            % --- Check file (compatibility wih previous version of MLab)
            if this.exist
                try 
                    this.get_header;
                catch
                    tmp = load(this.full);
                    
                    if isfield(tmp, 'M')
                        
                        % --- Replace file
                        delete(this.full);
                        F = ML.matfile(this.full);
                        F.set_header;
                        
                        M = matfile(this.full, 'Writable', true);
                        header = M.MLAB_header;
                        
                        f = fields(tmp.M);
                        for i = 1:numel(f)
                            
                            % Variable
                            M.(f{i}) = tmp.M.(f{i});
                            
                            % Descriptions
                            if isfield(tmp.M, 'txt'), header.description.(f{i}) = tmp.M.txt.f{i};
                            else, header.description.(f{i}) = ''; end
                            
                        end
                        
                        % --- Update header
                        M.MLAB_header = header;
                    end
                end
            end
            
        end
        
    end
end
