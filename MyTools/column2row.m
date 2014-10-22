function varargout = column2row(varargin)
% ROW2COLUMN - converts the inputs to row vectors.

    varargout = varargin;
    for i = 1:nargin
        if iscolumn(varargin{i})
            varargout{i} = transpose(varargin{i});
        end
    end
end
