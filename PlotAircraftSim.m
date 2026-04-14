function PlotAircraftSim(time, aircraft_state_array, control_input_array, fig, col, part)
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% GOAL: 
%   - Function should plot results of a full simulation once it is
%   complete. 
% INPUTS: 
%   - length n vectorwhich holds the time corresponding to the nth set of
%      variables
%   - aircraft state vector
%   - aircraft control inputs vector
%   - vector of figure numbers to plot over 
%   - string 'col' which indicates plotting option used for every plot
% OUTPUTS: 
%   - 6 figures
%   - 4 with 3 subplots for inertial position,Euler Angles,inertial
%   Velocity in body frame, and angular velocity
%   - 1 with four subplots for each control input variable
%   - 1 that shows the three dimensional path of the aircraft with
%   positivie height upward (this figure should indicate the start of the path
%   as green and the finish as red)
% COMMENTS: 
%   - The function must be able to be called multiple times for different
%   simulation runs with different 'col' indicators. The function should
%   call each fugure before plotting and include the 'hold on' command. It
%   should not clear figures before plotting
% EXAMPLE: 
    % figure(fig(1));
    % subplot(311);
    % plot(time,aircraft_state_array(1,:),col); hold on; 
    % subplot(312);
    % plot(time,aircraft_state_array(2,:),col); hold on; 
    % ...
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% Figures 1 - 4
    % Inertial Position
    figure(fig(1));
    hold on;
    subplot(311); plot(time, aircraft_state_array(1,:), col); hold on; ylabel('x_E [m]');
    subplot(312); plot(time, aircraft_state_array(2,:), col); hold on; ylabel('y_E [m]');
    subplot(313); plot(time, aircraft_state_array(3,:), col); hold on; ylabel('z_E [m]');set(gca, 'YDir', 'reverse');
    xlabel('Time [s]');
    sgtitle('Inertial Position vs Time'); 
    print(fullfile("Part 3 Figures/",[part + '-Figure-' + num2str(fig(1)) + '.png']),'-r300','-dpng')

    % Euler Angles
    figure(fig(2));
    hold on;
    subplot(311); plot(time, aircraft_state_array(4,:), col); hold on; ylabel('\phi [rad]');
    subplot(312); plot(time, aircraft_state_array(5,:), col); hold on; ylabel('\theta [rad]');
    subplot(313); plot(time, aircraft_state_array(6,:), col); hold on; ylabel('\psi [rad]');
    xlabel('Time [s]');
    sgtitle('Euler Angles vs Time');
    print(fullfile("Part 3 Figures/",[part + '-Figure-' + num2str(fig(2)) + '.png']),'-r300','-dpng')

    % Inertial Velocity in Body Frame
    figure(fig(3));
    hold on;
    subplot(311); plot(time, aircraft_state_array(7,:), col); hold on; ylabel('u [m/s]');
    subplot(312); plot(time, aircraft_state_array(8,:), col); hold on; ylabel('v [m/s]');
    subplot(313); plot(time, aircraft_state_array(9,:), col); hold on; ylabel('w [m/s]');
    xlabel('Time [s]');
    sgtitle('Inertial Velocity vs Time');
    print(fullfile("Part 3 Figures/",[part + '-Figure-' + num2str(fig(3)) + '.png']),'-r300','-dpng')

    % Angular Velocity
    figure(fig(4));
    hold on;
    subplot(311); plot(time, aircraft_state_array(10,:), col); hold on; ylabel('p [rad/s]');
    subplot(312); plot(time, aircraft_state_array(11,:), col); hold on; ylabel('q [rad/s]');
    subplot(313); plot(time, aircraft_state_array(12,:), col); hold on; ylabel('r [rad/s]');
    xlabel('Time [s]');
    sgtitle('Angular Velocity vs Time');
    print(fullfile("Part 3 Figures/",[part + '-Figure-' + num2str(fig(4)) + '.png']),'-r300','-dpng')

    %% Figure 5


    % convert to degrees
    deg_control_input_array(1,:) = rad2deg(control_input_array(1,:));
    deg_control_input_array(2,:) = rad2deg(control_input_array(2,:));
    deg_control_input_array(3,:) = rad2deg(control_input_array(3,:));



    % Control Input Variables
    figure(fig(5));
    hold on;
    subplot(411); plot(time, deg_control_input_array(1,:), col); hold on; ylabel('\delta_e (Deg)');
    ylim([-10,25])
    subplot(412); plot(time, deg_control_input_array(2,:), col); hold on; ylabel('\delta_a (Deg)');
    subplot(413); plot(time, deg_control_input_array(3,:), col); hold on; ylabel('\delta_r (Deg)');
    subplot(414); plot(time, control_input_array(4,:), col); hold on; ylabel('\delta_t (Fractional)');
    xlabel('Time [s]');
    sgtitle('Control Input vs Time');
    print(fullfile("Part 3 Figures/",[part + '-Figure-' + num2str(fig(5)) + '.png']),'-r300','-dpng')

    %% Figure 6 

    % Three-Dimensional Path
    figure(fig(6));
    plot3(aircraft_state_array(1,:), aircraft_state_array(2,:), -aircraft_state_array(3,:), col); 
    hold on;
    
    % Indicate start (green) and finish (red) markers [1].
    plot3(aircraft_state_array(1,1), aircraft_state_array(2,1), -aircraft_state_array(3,1), 'go', 'MarkerSize', 8, 'LineWidth', 2);
    plot3(aircraft_state_array(1,end), aircraft_state_array(2,end), -aircraft_state_array(3,end), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    
    grid on; axis equal;
    xlabel('X_E Position [m]'); ylabel('Y_E Position [m]'); zlabel('Height [m]');
    title('3D Aircraft Path');
    print(fullfile("Part 3 Figures/",[part + '-Figure-' + num2str(fig(6)) + '.png']),'-r300','-dpng')
end

