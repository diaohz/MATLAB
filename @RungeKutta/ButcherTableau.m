function [A,b,c] = ButcherTableau(method_name)
%Butcher tableau for Runge-Kutta method: matrix A and vector b
%  method_name determines the choice of the specific RK methods.

    switch method_name
      case 'ImplicitEuler'
        A = 1;
        b = 1;
        c = 1;

      case 'RadauIIA3'   % Radau IIA s =2,p=3
        A = [5/12,-1/12;...
              3/4,  1/4];
        b = [3/4; 1/4];
        c = [1/3;   1];

      case 'RadauIIA5'   % Radau IIA s=3,p=5
        A = [    (88-7*sqrt(6))/360, (296-169*sqrt(6))/1800, (-2+3*sqrt(6))/225;...
             (296+169*sqrt(6))/1800,     (88+7*sqrt(6))/360, (-2-3*sqrt(6))/225;...
                    (16-sqrt(6))/36,        (16+sqrt(6))/36,                1/9];
        b = [(16-sqrt(6))/36; (16+sqrt(6))/36; 1/9];
        c = [ (4-sqrt(6))/10;  (4+sqrt(6))/10;  1];

      case 'LobattoIIIC2' % Lobatto IIIC s=2,p=2
        A = [1/2, -1/2;...
             1/2,  1/2];
        b = [1/2; 1/2];
        c = [  0;   1];

      case 'LobattoIIIC4' % Lobatto IIIC s=3,p=4
        A = [1/6, -1/3,   1/6;...
             1/6, 5/12, -1/12;...
             1/6,  2/3,   1/6];
        b = [1/6; 2/3; 1/6];
        c = [  0; 1/2;   1];

      case 'LobattoIIIC6' % Lobatto IIIC s=4,p=6
        A = [1/12,       -sqrt(5)/12,        sqrt(5)/12,       -1/12;...
             1/12,               1/4, (10-7*sqrt(5))/60,  sqrt(5)/60;...
             1/12, (10+7*sqrt(5))/60,               1/4, -sqrt(5)/60;...
             1/12,              5/12,              5/12,        1/12];
        b = [1/12; 5/12; 5/12; 1/12];
        c = [   0; (5-sqrt(5))/10; (5+sqrt(5))/10; 1];

      case 'LobattoIIIC8' % Lobatto IIIC s=5,p=8
        A = [1/20,                   -7/60,                 2/15,                   -7/60,   1/20;...
             1/20,                  29/180, (47-15*sqrt(21))/315,  (203-30*sqrt(21))/1260, -3/140;...
             1/20, (329+105*sqrt(21))/2880,               73/360, (329-105*sqrt(21))/2880,  3/160;...
             1/20,  (203+30*sqrt(21))/1260, (47+15*sqrt(21))/315,                  29/180, -3/140;...
             1/20,                  49/180,                16/45,                  49/180,   1/20];
        b = [1/20; 49/180; 16/45; 49/180; 1/20];
        c = [   0; (7-sqrt(21))/14; 1/2; (7+sqrt(21))/14; 1];

      case 'Gauss2' % Gauss s=1,p=2
        A = 1/2;
        b = 1/2;
        c = 1;

      case 'Gauss4' % Gauss s=2,p=4
        A = [          1/4, 1/4-sqrt(3)/6; ...
             1/4+sqrt(3)/6,           1/4];
        b = [1/2; 1/2];
        c = [1/2-sqrt(3)/6; 1/2+sqrt(3)/6];

      case 'Gauss6' % Gauss s=3,p=6
        A = [            5/36, 2/9-sqrt(15)/15, 5/36-sqrt(15)/30; ...
             5/36+sqrt(15)/24,             2/9, 5/36-sqrt(15)/24; ...
             5/36+sqrt(15)/30, 2/9+sqrt(15)/15,             5/36];
        b = [5/18; 4/9; 5/18];
        c = [1/2-sqrt(15)/10; 1/2; 1/2+sqrt(15)/10];

      otherwise
        error('***ERROR: Invalid input for choosing Runge-Kutta method!');
    end
end
