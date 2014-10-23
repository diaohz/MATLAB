classdef rization < handle
% Abstract class for parametrization
% y = fun(x)
% dy(x)/dx = dfun(x)

    properties (SetAccess=protected)
        name
    end

    %% properties %%
    %% methods    %%

    methods (Abstract=true)
        [y, dydx] = x2y(obj, x)
        [x, dxdy] = y2x(obj, y) % the inverse mapping
    end

end