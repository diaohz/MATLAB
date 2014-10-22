function dd = divdiff(x, y)
% NEWTONDD - calculates the coefficients for polynomial interpolation in Newton's form.
% The output dd is a row vector that contains f[x0], f[x0,x1], ... , f[x0,x1,...,xn]
% It can only handle vector inputs.

    [x, y] = row2column(x,y);
    len = length(y);

    dd = zeros(len,len);
    dd(:,1) = y; % f[x0]

    for i = 2:len
        front= 1:len-i+1;
        back = i:len;
        dd(front, i) = (dd(back-(i-2),i-1) - dd(front,i-1)) ./ ... ;
                       (x(back) - x(front));
    end

    dd = dd(1,:);
end
