function [xdot, aircraft_surfaces] = AircraftEOMDoublet(time, aircraft_state, aircraft_surfaces, doublet_size, doublet_time, wind_inertial, aircraft_parameters)

%LABTASK3P1 This function simulates the fixed wing aircraft equations of
%motion, including a negative pulse to the elevator, simulating a doublet
%mode. The function then outputs the derivative of the state vector, to be
%integrated using ode45.


% set up piecewise function to calc del_e
% initialize elevator deflection
del_e = aircraft_surfaces(1);

% piecewise doublet: positive pulse then negative pulse, else zero
if (time >= 0) && (time <= doublet_time)
    del_e = del_e + doublet_size;

elseif (time > doublet_time) && (time <= 2*doublet_time)
    del_e = del_e - doublet_size; 

elseif time > 2*doublet_time
    del_e = 0.1079; % set to trim if elevator isnt deflected
else
    disp('Error')
    
end

aircraft_surfaces(1) = del_e;


Ix = aircraft_parameters.Ix;
Iy = aircraft_parameters.Iy;
Iz = aircraft_parameters.Iz;
Ixz = aircraft_parameters.Ixz;

xdot = zeros(12, 1);

x_E = aircraft_state(1);
y_E = aircraft_state(2);
z_E = aircraft_state(3);
phi = aircraft_state(4);
theta = aircraft_state(5);
psi = aircraft_state(6);
u_E = aircraft_state(7);
v_E = aircraft_state(8);
w_E = aircraft_state(9);
p = aircraft_state(10);
q = aircraft_state(11);
r = aircraft_state(12);

A1 = [cos(theta)*cos(psi), (sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi)), (cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi));
    cos(theta)*sin(psi), (sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi)), (cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi));
    -sin(theta), sin(phi)*cos(theta), cos(phi)*cos(theta)];

A2 = [1, sin(phi)*tan(theta), cos(phi)*tan(theta);
    0, cos(phi), -sin(phi);
    0, sin(phi)*sec(theta), cos(phi)*sec(theta)];

A3 = [(r*v_E - q*w_E), (p*w_E - r*u_E), (q*u_E - p*v_E)]';

A4 = [-sin(theta), cos(theta)*sin(phi), cos(theta)*cos(phi)]';

% Lambdas
Lam = Ix*Iz-Ixz^2;
L1 = (Ixz*(Ix-Iy+Iz)/Lam);
L2 = (Iz*(Iz-Iy)+Ixz^2)/Lam;
L3 = Iz/Lam;
L4 = Ixz/Lam;
L5 = (Iz-Ix)/Iy;
L6 = Ixz/Iy;
L7 = (Ix*(Ix-Iy)+Ixz^2)/Lam;
L8 = Ix/Lam;

A5 = [L1*p*q-L2*q*r, L5*p*r-L6*(p^2-r^2), L7*p*q-L1*q*r]';

rho = stdatmo(abs(z_E));
[aero_forces, aero_moments] = AeroForcesAndMoments(aircraft_state, aircraft_surfaces, wind_inertial, rho, aircraft_parameters);

X = aero_forces(1);
Y = aero_forces(2);
Z = aero_forces(3);
L = aero_moments(1);
M = aero_moments(2);
N = aero_moments(3);

A6 = [X,Y,Z]';

A7 = [L3*L+L4*N, M/Iy, L4*L+L8*N]';

var_dot_XYZ = A1*[u_E, v_E, w_E]';
var_dot_O = A2*[p, q, r]';
var_dot_UVW = A3 + aircraft_parameters.g*A4 + (1/aircraft_parameters.m)*A6;
var_dot_PQR = A5 + A7;

xdot(1) = var_dot_XYZ(1);
xdot(2) = var_dot_XYZ(2);
xdot(3) = var_dot_XYZ(3);

xdot(4) = var_dot_O(1);
xdot(5) = var_dot_O(2);
xdot(6) = var_dot_O(3);

xdot(7) = var_dot_UVW(1);
xdot(8) = var_dot_UVW(2);
xdot(9) = var_dot_UVW(3);

xdot(10) = var_dot_PQR(1);
xdot(11) = var_dot_PQR(2);
xdot(12) = var_dot_PQR(3);



end