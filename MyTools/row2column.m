function varargout = row2column(varargin)
% ROW2COLUMN - converts the inputs to column vectors.

    varargout = varargin;
    for i = 1:nargin
        if isrow(varargin{i})
            varargout{i} = transpose(varargin{i});
        end
    end
end
