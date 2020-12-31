function plotTimeDepth(t, pres, dist, fig, start)
    % This function plots and updates the plot for the depth of the river along time
    % this function is not used, we are using plotTimePresDepth instead
    % - x := time of each measurement
    % - y := depth of the river
    %
    % Args:
    % (double) t     := time of the measurement
    % (double) pres  := depth of the ROUV
    % (double) dist  := distance from ROUV to river bed
    % (Figure) fig   := figure where to plot
    % (bool)   start := initialize vars to 0 (for runing function first time)
    %
    % Return:
    % ~

    % set t and y as global so they have 'memory' and dont reset every time
    global tTimeDepth yTimeDepth
    % (double vector) tTimeDepth := vector containing the time of each measurement
    % (double vector) yTimeDepth := vector containing the measurements of the depth of the river
    
    % set start to default value if arg not given
    if ~exist('start', 'var')
        start = false;
    end
    
    % load config
    global param
    
    % if it's first time executing initialize vars (t, y)
    if start
        tTimeDepth = [-param.secWidth:param.Tsampling:0];
        yTimeDepth = zeros(1, length(tTimeDepth));
    end

    % add new data to vectors
    tTimeDepth = [tTimeDepth(2:end) tTimeDepth(end) + t];
    nexty = pres-dist; % pres is negative dist is positive
    yTimeDepth = [yTimeDepth(2:end) nexty];

    % plot
    figure(fig)
    plot(tTimeDepth, yTimeDepth, param.lineDepthColor);
    hold on
    
    title('River bed depth along time');
    xlabel('Time [s]');
    ylabel('Depth [m]');
    ylim([param.maxRiverBedDepth 0]);
    xlim([tTimeDepth(1) tTimeDepth(end)]);

    drawnow;
end
