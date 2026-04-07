% !! this will not run !!
% just an example of how to save the plots 
for i = 1: size(PertStates,2)

    % figure numbers per case (if multiple cases)
    % current_figs = ((i-1)*6) + fig_nums;

    % Create folder for each case
    folder = sprintf('FolderNameHere_%d', i); % change the name of the folder per task. The i, is if there are multiple cases
    if ~exist(folder, 'dir')
        mkdir(folder);
    end

        PlotAircraftSim(cases(i).t',cases(i).states' ,cases(i).ControlFandG' , ((i-1)*6)+fig_nums, 'b-');

        % Save each figure
    for k = 1:length(current_figs)
        f = figure(current_figs(k));   % grab figure handle

        filename = sprintf('%s/Fig_%d.png', folder, k);
        exportgraphics(f, filename, 'Resolution', 300);
    end



end