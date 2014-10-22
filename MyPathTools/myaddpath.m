function myaddpath(varargin)
    
    mypath = pwd;
    ISrecursive = false;

    if nargin==0
        % Use the above default values.
    elseif nargin==1 && islogical(varargin{1})
        ISrecursive = varargin{1};

    elseif nargin==1 && ischar(varargin{1})
        mypath = pth2fullpath(varargin{1});

    elseif nargin==2 && ischar(varargin{1}) && islogical(varargin{2})
        mypath = pth2fullpath(varargin{1});
        ISrecursive = varargin{2};

    else
        error('*** The input arguments are not correct!');
    end
    
    if ISrecursive
        mypath = genpath(mypath);
    end
    addpath(mypath, '-begin');
end
