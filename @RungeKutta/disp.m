function disp(obj)
    % display the infomation of the method
    fprintf(1,'ODE solver: %s\n',obj.name);
    fprintf(1,'     stage: %u\n',obj.stage);
    fprintf(1,'     order: %u\n',obj.order);

    fprintf(1,'\n');

    % display Butcher tableau
    fprintf(1,'The Butcher tableau is :\n');
    RungeKutta.DispButcherTableau(obj.A, obj.b, obj.c);

    fprintf(1,'\n');

    % display the eigenvalue information
    fprintf(1,'The eigenvalues of A are :\n');
    builtin('disp', transpose(obj.lambda));

    % display the sector information
    fprintf(1,'sector angle: %5.2f degree\n',obj.sectorAngle);
end % function disp
