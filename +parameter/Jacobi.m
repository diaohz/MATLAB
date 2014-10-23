classdef Jacobi < parameter.rization
    properties (SetObservable=true, AbortSet=true)
        L % Jacobi paramter provided by the user
    end

    properties (SetAccess=private)
        k % Jacobi modulus determined by k

        K  % complete elliptic integral of the first kind
        Kp % complementary parameter
    end

    %% properties %%
    %% methods    %%

    methods
        function jobj = Jacobi(l)
        % jobj: JacobiObject
            jobj.name = 'Jacobi Elliptic';

            jobj.L = l;
        end
        function set.L(jobj, l)
            jobj.L = l;
            jobj.k = sqrt(exp(-2*pi*l));
            [jobj.K, jobj.Kp] = ellipkkp(l);
        end

        function [y, dydx] = x2y(jobj, x)
            [sn, cn, dn] = ellipjc(x, jobj.L);            

            y = sn;
            dydx = cn .* dn;
        end
        function [x, dxdy] = y2x(jobj, y)
            error('*** The inverse mapping for Jacobi elliptic function is in construction.');
     end

        function disp(jobj)
            fprintf(1,'%s Transformation\n',jobj.name);
            fprintf(1,'          Jacobi modulus  : k =%7.4f\n',jobj.k);
            fprintf(1,'          Jacobi parameter: L =%7.4f\n',jobj.L);
            fprintf(1,'complete elliptic integral: K =%7.4f\n',jobj.K);
            fprintf(1,'   complementary parameter: Kp=%7.4f\n',jobj.Kp);
        end
    end
end