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
clear;
clc;
close all;

aircraft_parameters = ttwistor;
wind_inertial = [0;0;0];

% Define what part to run, if you want all then input 0
part = 2;

if part==1 || part == 0
% initial state vector 
x0 = [0,0,-1609.34,0,0,0,21,0,0,0,0,0]';

% initial control vector
u0 = [0,0,0,0]';

% call to EOM function 
[t1,var1] = ode45(@(t1,var1) AircraftEOM(t1, var1, u0, wind_inertial, aircraft_parameters), [0,200], x0);
control = repmat(u0, 1 ,length(t1));

% call to plot aircraftsim
PlotAircraftSim(t1, var1', control , [1;2;3;4;5;6], 'b',"2-1")
%}
end

if part == 2 || part == 0
% initial state vector 
x0 = [0,0,-1800,0,.02780,0,20.99,0,.5837,0,0,0]'; % NOTE: .02780 is in radians and everything else is in degrees and meters

% initial control vector
u0 = [.1079,0,0,.3182]'; % radians

% call to EOM function 
[t2,var2] = ode45(@(t2,var2) AircraftEOM(t2, var2, u0, wind_inertial, aircraft_parameters), [0,200], x0);
control = repmat(u0, 1 ,length(t2));

% call to plot aircraftsim
PlotAircraftSim(t2, var2', control , [1;2;3;4;5;6], 'b',"2-2")

end
if part == 3 || part == 0 
x0 = [0,0,-1800,deg2rad(15),deg2rad(-12),deg2rad(270),19,3,-2,deg2rad(0.08),deg2rad(-0.2),deg2rad(0)]'; % NOTE: units are [m],[rad],[m\s],[deg/s]

% initial control vector
u0 = [deg2rad(5),deg2rad(2),deg2rad(-13),0.3]'; % convert deg to rad

% call to EOM function 
[t3,var3] = ode45(@(t3,var3) AircraftEOM(t3, var3, u0, wind_inertial, aircraft_parameters), [0,200], x0);
control = repmat(u0, 1 ,length(t3));

% call to plot aircraftsim
PlotAircraftSim(t3, var3', control , [1;2;3;4;5;6], 'b',"2-3")
end