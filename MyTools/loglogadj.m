function varargout = loglogadj(X,Y, deltaINy)
% LOGLOGADJ - adjust the order reference line to an appropriate postion in a log-log plot
% A good funtionality of the subroutine is based on the fact that
% the input data X and Y has a linear relation in a log-log plot, namely
% log(Y) = a*log(X) + b.
% 'deltaINy' is optional and controls how close the order reference
% is close to the error plot.

    % Check the positivity of the input data X and Y.
    if all(X>0)
        if all(Y>0)
        else
            error('*** The input ''Y'' mustn''t contain non-positive values.');
        end
    else
        error('*** The input ''X'' mustn''t contain non-positive values.');
    end

    logX = row2columnINlog(X);
    logY = row2columnINlog(Y);

%     b = regress(logY, [ones(length(logX),1), logX]); % logY = b1+b2*logX
    b = lst(logY, logX);
    slope = b(2);

    % deltaINy = log10(ytarget) - log10(Y(1));
    if nargin==2
        deltaINy = -0.1*abs(log10(Y(1)));
    end

    % "deltaINx" is the horizontal displacement.
    % Its value is calculated by using the triangle similarity.
    deltaINx = -slope*deltaINy/(1+slope^2);

    if deltaINy>0
        logX(1) = logX(1)+deltaINx;
    else
        logX(end) = logX(end)+deltaINx;
    end

    Xref = 10.^logX;
    Yref = 10.^( deltaINy+b(1) + slope * logX );

    slope = round(slope*10)/10; % The slope is rounded to x.x form.

	if nargout<=1
		varargout{1} = slope;
	elseif nargout==3
		varargout{1} = Xref;
		varargout{2} = Yref;
		varargout{3} = slope;
	else
		error('*** The output arguments are inappropriate.');
	end
end

function output = row2columnINlog(input)
% ROW2COLUMNINLOG - takes the logarithm of the input
%                   and output in column array
    if isrow(input)
        input = transpose(input);
    end

    output = log10(input);
end

function coe = lst(Y,X)
% LST - Find the linear approximation y = a + bx
%       to the input data pairs (X,Y).
%       coe = [a;b]
%       [vec1, X][a;b]=Y

    [X,Y] = row2column(X,Y);

    M = [ones(size(X,1),1), X];

    MTM = M'*M;
    MTY = M'*Y;
    coe = MTM\MTY;
    
end
