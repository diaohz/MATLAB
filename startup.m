% set(0,'DefaultFigureWindowStyle','docked');

my_linewidth = 1.5;
set(0,'DefaultLineLineWidth',my_linewidth);
clear my_linewidth

my_fontsize = 10;
set(0,'DefaultAxesFontSize',my_fontsize);
set(0,'DefaultTextFontSize',my_fontsize);
clear my_fontsize

set(0, 'DefaultAxesBox', 'on');

% set(0,'defaultAxesXGrid','on');
% set(0,'defaultAxesYGrid','on');

addpath(genpath('~/Documents/MATLAB/MyTools'), '-begin');
addpath(genpath('~/Documents/MATLAB/MyPathTools'), '-begin');

addpath(genpath('~/Documents/MATLAB/Driscoll_SC'), '-begin');
addpath(genpath('~/Documents/MATLAB/Mesh2d_v24'), '-begin');

addpath(genpath('~/Documents/MATLAB/CQfunctions'), '-begin');
