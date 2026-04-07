clear; close all; clc;
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Goal: 
%    - Use ode45 to simulate aircraft EOM for 3 seconds
%    - Plot the results from .5 sec to 1.5 sec i.e (short period mode)
%    - Estimeate the natural frequency and damping ratio of the short
%    period mode of the aircraft
% Comments: 
%   - The initial state and control inputs are the trim values from problem
%   2.2
%   - Apply a doublet of size 15 degrees and duration doublet_time = .25
%   sec
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% initial state vector 
x0 = [0,0,-1800,0,.02780,0,20.99,0,.5837,0,0,0]'; % NOTE: .02780 is in radians and everything else is in degrees and meters

% initial control vector
u0 = [.1079,0,0,.3182]'; % radians

% doublet duration
doublet_time = 0.25; % seconds

% call to EOM function 

% figure numbers 
figNums = 1:6; 


% call to plot aircraftsim
PlotAircraftSim()

% saving figures 
save = 0; 

if save
    folder = sprintf('LabTask3p1'); % change the name of the folder per task. The i, is if there are multiple cases
    if ~exist(folder, 'dir')
        mkdir(folder);
    end

       % will put call to plot aircraft sim in here after it works 

        % Save each figure
    for k = 1:length(figNums)
        f = figure(current_figs(k));   % grab figure handle

        filename = sprintf('%s/Fig_%d.png', folder, k);
        exportgraphics(f, filename, 'Resolution', 300);
    end

end