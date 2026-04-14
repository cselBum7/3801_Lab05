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


aircraft_parameters = ttwistor;

% initial state vector 
aircraft_state = [0,0,-1800,0,.02780,0,20.99,0,.5837,0,0,0]'; % NOTE: .02780 is in radians and everything else is in degrees and meters

% initial control vector
aircraft_surfaces = [.1079,0,0,.3182]'; % radians

% doublet duration
doublet_time = 0.25; % seconds

doublet_size = deg2rad(15); % in rad

% set wind inertial
wind_inertial = [0;0;0];


% call to EOM function 
t_span = [0,3];

[t, var] = ode45(@(t, aircraft_state) AircraftEOMDoublet(t, aircraft_state, aircraft_surfaces, doublet_size, doublet_time, wind_inertial, aircraft_parameters), t_span, aircraft_state);


del_e = repmat(aircraft_surfaces(1), 1, length(t));

% output control surface
for i = 1:length(t)
if (t(i) >= 0) && (t(i) <= doublet_time)
    del_e(i) = del_e(i) + doublet_size;

elseif (t(i) > doublet_time) && (t(i) <= 2*doublet_time)
    del_e(i) = del_e(i) - doublet_size; 

elseif t(i) > 2*doublet_time
    del_e(i) = 0.1079; % set to trim if elevator isnt deflected
else
    disp('Error')
    
end

end

control_input_array = repmat(aircraft_surfaces, 1, length(t));

control_input_array(1, :) = del_e;


% figure numbers 
figNums = 1:6; 

col = '-b';


% call to plot aircraftsim
PlotAircraftSim(t, var', control_input_array, figNums, col, "3-1")



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