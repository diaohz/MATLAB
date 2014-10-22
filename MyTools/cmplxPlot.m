function varargout = cmplxPlot(varargin)
% CMPLXPLOT - plots the complex value solution on the xy plane.
% ATTENTION: MATLAB only allows 'Color', 'MarkerSize' and 'LineWidth'
%            to appear at the end of argument list.

    data = {};
    east=[]; west=[]; north=[]; south=[];

    i = 0;
    while i<nargin
        i = i+1;
        tmp = varargin{i};

        if isnumeric(tmp)
            tmpreal = real(tmp);
            tmpimag = imag(tmp);

            data = [data, {tmpreal, tmpimag}];

            % Locate the outskirt of the subject.
            east = [east, max(tmpreal)];
            west = [west, min(tmpreal)];
            north= [north,max(tmpimag)];
            south= [south,min(tmpimag)];

        elseif ischar(tmp) && ...
               ismember(tmp, {'Color','color','LineWidth','linewidth','MarkerSize','markersize'})
               % The seeking has reached the end part of the argument list.
               % The rest argument from now on only contains parameters for LineWidth and MarkerSize.

            data = [data, varargin{i:nargin}];
            i = nargin; % Jump of out the loop.
        else
            data = [data, {tmp}];
        end
    end

    HandleOfPlot = plot(data{:});

    % Place the subjects in the centre of the figure.
    east = max(east); west = min(west); north = max(north); south = min(south);
    dr = 0.2*min(east-west, north-south); % 'dr' controls the margin in both directions.
    rx = 0.5*(east - west) + dr;
    ry = 0.5*(north-south) + dr;
    xbound = [-rx, rx] + (west+east)/2;
    ybound = [-ry, ry] + (south+north)/2;
    axis equal; axis([xbound ybound]);

    if nargout>0
        varargout{1} = HandleOfPlot;
    end
end
