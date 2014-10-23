classdef Composition < parameter.rization
    properties
        % The cell contains the objects of each mapping.
        % The mapping sequence is
        % x -> objlist{1} -> objlist{2} -> objlist{3} -> ... -> y
        objlist
    end

    properties (Access=private)
        n % number of objects on the OBJLIST
    end

    %% properties %%
    %% methods    %%

    methods
        function cobj = Composition(varargin)
            % cobj: Composition Object
            cobj.name = 'Composite';

            % cobj.objlist = objectCell;
            cobj.objlist = varargin;

        end

        function set.objlist(cobj, objectCell)
            cobj.objlist = objectCell;
            cobj.n = length(objectCell);
        end

        function [y,dydx] = x2y(cobj, x)

            dydx = ones(size(x));
            for i = 1:cobj.n
                 [x, tmp] = cobj.objlist{i}.x2y(x);
                 dydx = dydx.*tmp;
            end

            y = x;
        end
        function [x,dxdy] = y2x(cobj, y)

            dxdy = ones(size(y));
            for i = 1:cobj.n
                 [y, tmp] = cobj.objlist{i}.y2x(y);
                 dxdy = dxdy.*tmp;
            end

            x = y;
        end

        function disp(cobj)
            fprintf(1,'%s Transformation maps\n',cobj.name);
            fprintf(1,'%5s --> ','X');
            for i = 1:cobj.n
                fprintf(1,'%s --> ',cobj.objlist{i}.name);
            end
            fprintf(1,'%s.\n','Y');
        end
    end
end