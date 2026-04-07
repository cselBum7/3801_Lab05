% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Goal: 
%    - Function check to see if EOM works 
% Comments: 
%   - The aircraft initial state and control inputs all set to zero except 
%     the inertial velocity component in the body 𝑥𝑥-direction is set to the
%     airspeed 𝑉𝑉 = 21 m/s and the height is set to ℎ = 1609.34 m (1 mile =
%     Boulder, CO!). The main purpose of this simulation is to verify that 
%     your simulation works, since the aircraft should stay near the trim 
%     flight condition. Why should we not expect this to be a trim
%     condition?
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% initial state vector 
x0 = [0,0,-1609.34,21,0,0,0,0,0,0,0,0]';

% initial control vector
u0 = [0,0,0,0]';

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