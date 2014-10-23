classdef Moebius < parameter.rization
    properties (SetObservable=true, AbortSet=true)
        xpoints
        ypoints
    end

    properties (SetAccess=private, Hidden=true)
    % coefficients that determines the transformation
    % f(x) = (a*x+b)/(c*x+d)

        a
        b
        c
        d
    end

    %% properties %%
    %% methods    %%

    methods
        function mobj = Moebius(ulist, zlist)
        % mobj: Moebius Object
        % u-plane --> z-plane
            mobj.name = 'Moebius';

            mobj.xpoints = ulist;
            mobj.ypoints = zlist;

            coeff4moebius(mobj);

            addlistener(mobj, 'xpoints','PostSet',@(src,evnt) coeff4moebius(mobj, src, evnt));
            addlistener(mobj, 'ypoints','PostSet',@(src,evnt) coeff4moebius(mobj, src, evnt));
        end

        function [y, dydx] = x2y(mobj, x)
            y = ( mobj.a*x + mobj.b ) ./ ( mobj.c*x + mobj.d );
            dydx = (mobj.a*mobj.d - mobj.b*mobj.c) ./ ( mobj.c*x + mobj.d ).^2;
        end
        function [x, dxdy] = y2x(mobj, y)
            x = ( -mobj.d*y + mobj.b ) ./ ( mobj.c*y - mobj.a );
            dxdy = (mobj.a*mobj.d - mobj.b*mobj.c) ./ ( mobj.c*y - mobj.a ).^2;
        end

        function disp(mobj)
            fprintf(1,'%s Transformation\n',mobj.name);
            fprintf(1,'       a*x+b\n');
            fprintf(1,'f(x) = -----\n');
            fprintf(1,'       c*x+d\n');

            fprintf(1,'\n');

            fprintf(1,'   a =%11.3e\n',mobj.a);
            fprintf(1,'   b =%11.3e\n',mobj.b);
            fprintf(1,'   c =%11.3e\n',mobj.c);
            fprintf(1,'   d =%11.3e\n',mobj.d);
        end
    end

    methods (Access=private)
        function coeff4moebius(mobj)
            funMTX = @(p) [1, -p(1);1, -p(3)] .* repmat([p(2)-p(3);p(2)-p(1)], 1,2);

            %% funMTX(z) -> S(z) and funMTX(u) -> T(u)
            %% The following line computes the matrix for the composition (S^{-1}°T)(u).
            mtx4f = funMTX(mobj.ypoints) \ funMTX(mobj.xpoints);

            mobj.a = mtx4f(1,1); mobj.b = mtx4f(1,2);
            mobj.c = mtx4f(2,1); mobj.d = mtx4f(2,2);
        end
    end
end