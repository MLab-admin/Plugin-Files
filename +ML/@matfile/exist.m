function b = exist(this, varargin)
%[matfile].exist Tell if mat-file exists or if variable in matfile exists
%   B = [matfile].EXIST() returns a boolean saying if the file exists or
%   not.
%
%   B = [matfile].EXIST(VAR1, VAR2, ...) returns a boolean array saying if 
%   variables VAR1, VAR2, ... exist in the matfile.
%
%   See also: ML.matfile, ML.matfile.infos.

if isempty(varargin)

    b = exist(this.full, 'file');
    
else
   
     M = matfile(this.full);
     b = ismember(varargin, setdiff(who(M), 'MLAB_header'));
    
end