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
x0 = [0,0,-1609.34,21,0,0,0,0,0,0,0,0];

% initial control vector
u0 = [0,0,0,0];

% call to EOM function 

% call to plot aircraftsim