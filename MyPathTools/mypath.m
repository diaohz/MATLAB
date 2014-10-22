function mypath(varargin)
% MYPATH - Print the first n paths.

    if isempty(varargin)
        n = 5;
    else
        n = varargin{1};
    end

    p = path;
    idx = find(p==':', n);

    if ~isrow(idx), idx=idx'; end

    idx_head = [1, idx(1:n-1)+1];
    idx_tail = idx-1;

    for i = 1:n
        pidx = idx_head(i):idx_tail(i);
        disp([p(pidx)]);
    end
end
