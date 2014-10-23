classdef RungeKutta < handle

    properties
        name
    end

    properties (SetAccess=private)
        stage
        order
        stageOrder % stage order

        A
        b
        c

        V
        Vm1
        lambda

        vec1
        I % identity matrix

        sectorAngle

        boun4stab
    end % properties (SetAccess=private)

    %% properties %%
    %% methods    %%

    methods
        function obj = RungeKutta(name4solver)
            if isempty(name4solver)
                obj.name = 'ImplicitEuler';
            elseif ischar(name4solver)
                obj.name = name4solver;
            else
                error('***ERROR: Invalid input for the class constructor RUNGEKUTTA!');
            end
        end

        function set.name(obj,name4solver)
            obj.name = name4solver;

            [obj.A,obj.b,obj.c] = RungeKutta.ButcherTableau(name4solver);

            obj.stage = size(obj.A, 1);
            [obj.order, obj.stageOrder] = RungeKutta.OrderOfMethod(obj.name, obj.stage);

            obj.vec1 = ones(obj.stage,1);
            obj.I = eye(obj.stage);

            [V,D] = eig(obj.A);
            obj.V = V;
            obj.Vm1 = obj.V\obj.I;
            obj.lambda = diag(D);

            [~,indu] = max(imag(obj.lambda)); % upper point
            [~,indl] = min(imag(obj.lambda)); % lower point
            obj.sectorAngle = radtodeg(angle(obj.lambda(indu))-angle(obj.lambda(indl)));

            obj.fun4SR;
        end % function set.name

        fun4SR(obj, n)

        disp(obj)

        boun4stab = plotSR(obj, scaler)

    end % methods

    methods (Static=true)
        [A,b,c] = ButcherTableau(method_name)

        [order, so] = OrderOfMethod(name,stage)

        DispButcherTableau(A,b,c)

    end % methods static

end % classdef
