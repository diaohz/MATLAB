function phi = compute_phi(n,g_prime,t0)
% Computes the exact solution of the time-domain boundary integral equation
% S\phi=g on the unit sphere and for special right-hand sides g.
%
% Input arguments: 
% n: For n=0 we have g(x,t)=g(t) a purely time-dependent right-hand side. 
%    For n=1 we have g(x,t)=g(t)Y_1^m, where Y_1^m is a spherical harmonic
%    of degree 1
% g_prime: First time deriative of g(t) as function_handle
% t0: Vector of points where the solution is evaluated
%
% Output argument:
% phi: Solution of the 1-dim problem as vector. For n=0 the solution of the
% BIE is phi, for n=1 the solution of the BIE is phi*Y_1^m
%
% Example:
% g_prime=@(t) (4*t.^3-2*t.^4).*exp(-2*t); % g(t) = t^4*exp(-2t)
% g_prime=@(t) -sin(2*t).*exp(-t).*(-4.*t.*cos(2*t)-sin(2*t)+sin(2*t).*t);
% %g(t)=sin(2t)^2*t*exp(-t)
% t0=linspace(0,10,200);
% phi=compute_phi(0,g_prime,t0);
% plot(t0,phi);


% In the case n=1 adaptive numerical quadrature is used. Increase tolerance
% if needed.
rel_quad_error_tol = 1.e-6;

g_prime=@(t) heaviside(t).*g_prime(t);

if n==0
    phi=zeros(1,length(t0));
    for k=0:floor(max(t0)/2)
        phi = phi + g_prime(t0-2*k);
    end
    phi=2*phi;
    
elseif n==1
    phi=zeros(1,length(t0));
    for k=0:floor(max(t0)/2)
        phi = phi + (-1).^k .* g_prime(t0-2*k);
    end
    
    for i=1:length(t0)
       int_fun = @(tau) sinh(tau).*g_prime(t0(i)-tau);
       phi(i)= phi(i)+ quadgk(int_fun,0,t0(i),'RelTol',rel_quad_error_tol);
    end
    
    for i=1:length(t0)
        if t0(i)>2
            for k=1:floor(t0(i)/2)
                int_fun = @(tau) 0;
                for j=1:k
                int_fun = @(tau) int_fun(tau)+(c_2(k,j)+c_3(k,j)*tau-c_3(k,j)*2*k).* ...
                    (tau-2*k).^(j-1) .* exp(tau-2*k) .* g_prime(t0(i)-tau);
                end
                phi(i)= phi(i)- quadgk(int_fun,2*k,t0(i),'RelTol',rel_quad_error_tol);
            end
        end
    end
    
    phi=2*phi;
end


function res = c_2(k,j)
res = 0;
for m=0:j-1
   res = res + (-1)^(k+1) * (1-(-1)^(j-m))*factorial(k) ...
       / (factorial(j-1)*factorial(m)*factorial(k-j)*factorial(j-m) ); 
end

function res = c_3(k,j)
   res = (-1)^(k+1) * 2^(j-1) * factorial(k-1) ...
       / ( factorial(j-1)*factorial(j)*factorial(k-j) ); 


