clear; close all; clc;
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Goal: 
%    - Use ode45 to simulate aircraft EOM 
%    - Repeat the simulation for 3p1 but let run for 100 seconds
%   - Estimate the natural frequency and damping ratio of the phugoid mode
%   of the a/c
% Comments: 
%   - The initial state and control inputs are the trim values from problem
%   2.2
%   - Apply a doublet of size 15 degrees and duration doublet_time = .25
%   sec
%   - The slow oscillation eg. in the variable u_E is the phugoid moal
%   response of the a/c. 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% initial state vector 
x0 = [0,0,-1800,0,.02780,0,20.99,0,.5837,0,0,0]'; % NOTE: .02780 is in radians and everything else is in degrees and meters

% initial control vector
u0 = [.1079,0,0,.3182]'; % radians

% doublet duration
doublet_time = .25; % secons

% call to EOM function 

% figure numbers 
figNums = 1:6; 


% call to plot aircraftsim
PlotAircraftSim()

% saving figures 
save = 0; 

if save
    folder = sprintf('LabTask2p1'); % change the name of the folder per task. The i, is if there are multiple cases
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