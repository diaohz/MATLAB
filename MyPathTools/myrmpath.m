function myrmpath(n)
% MYRMPATH - remove first-n search paths
% By default, n=1 when there is not input argument.

    if nargin==0
        n = 1;
    end

    for i = 1:n
        p = path;
        idx = find(p==':');
        rmpath(p(1:idx-1));
    end

    mypath;
end
