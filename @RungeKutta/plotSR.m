function boun4stab = plotSR(obj, scaler)
% PLOTSR - plot the boundary of the stability region

    % "scaler" is usually the stepsize hmin.
    if nargin <2
        scaler = 1;
    end
    boun4stab = obj.boun4stab/scaler;
    boun4stab(end+1) = boun4stab(1); % Enclose the contour by adding a replica point.

    cmplxPlot(boun4stab,'k');

    xlabel('$\Re$','Interpreter','latex');
    ylabel('$\Im$','Interpreter','latex');

    rkname = obj.name(regexpi(obj.name,'[^0-9]'));
    title(['the stability region of ',rkname, ' method', ...
           ', stage ', num2str(obj.stage), ' with order ', num2str(obj.order)], ...
           'Interpreter','latex');
end
