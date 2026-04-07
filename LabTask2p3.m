clear; close all; clc;
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Goal: 
%    - Check an actual state and control vector
%    - plot a/c sim
% Comments: 
%   - not a trim state
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% initial state vector 
x0 = [0,0,-1800,15,-12,270,19,3,-2,deg2rad(0.08),deg2rad(-0.2),deg2rad(0)]'; % NOTE: units are [m],[rad],[m\s],[deg/s]

% initial control vector
u0 = [deg2rad(5),deg2rad(2),deg2rad(-13),0.3]'; % convert deg to rad

% call to EOM function 

% figure numbers 
figNums = 1:6; 


% call to plot aircraftsim
PlotAircraftSim()

% saving figures 
save = 0; 

if save
    folder = sprintf('LabTask2p3'); % change the name of the folder per task. The i, is if there are multiple cases
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