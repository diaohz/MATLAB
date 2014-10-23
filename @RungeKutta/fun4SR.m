function fun4SR(obj, n)
% FUN4SR - computes the stability region boundary of the Runge-Kutta method

    if nargin<2
        n = 100;
    end

    funR =@(z) (obj.A + z/(1-z)*obj.vec1*obj.b.') \ obj.I;

    zeta = 1*exp(1i*linspace(0,2*pi,n+2)); % unit circle
    zeta = zeta(2:n+1);

    obj.boun4stab = zeros(obj.stage, n);
    for nn = 1:n
        mtx = funR(zeta(nn));
        obj.boun4stab(:,nn) = eig(mtx);
    end

    obj.boun4stab = cmplxSort(obj.boun4stab);
end
