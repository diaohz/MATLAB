function out = ltscalar(z,n,m)

% Computes the n-th derivative with respect to z of the function
% K_m(z) = z^m * (1-exp(-2*z))/(2*z);
%This corresponds to the first eigenvalue for the boundary integral
%formulation of the wave equation on a sphere (Sauter, Veit, 2011).

if n==0
    out= z.^(m-1).*(1-exp(-2*z))/2;
else %n>=1. Leibniz rule
    out = 0*z;

    if m==0
        for ll=0:n-1
            out = out + ...
                nchoosek(n,ll)*factorial(ll)*2^(n-ll)*z.^(-1-ll).*exp(-2*z);
        end
        out = (-1)^(n+1)*out;
        out = out + factorial(n)*(-1)^(n)*z.^(-1-n).*(1-exp(-2*z));
    else %m>=1
        for ll=0:min(n-1,m-1)
            out = out - ...
                nchoosek(n,ll)*factorial(m-1)/factorial(m-1-ll)*(-2)^(n-ll)*z.^(m-1-ll).*exp(-2*z);
        end
        if m>=n+1
            out = out + factorial(m-1)/factorial(m-1-n)*z.^(m-1-n).*(1-exp(-2*z));
        end
    end
    out=out/2;
end