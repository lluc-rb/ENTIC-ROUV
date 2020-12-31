function plotDistDepth(pres, dist, lat, lon, fig, start)
    % This function plots and updates the plot for the depth of the river along the distance travelled
    % - x := distance traveled
    % - y := depth of the river
    %
    % Args:
    % (double) pres  := depth of the ROUV
    % (double) dist  := distance from ROUV to river bed
    % (double) lat   := latitude
    % (double) lon   := longitude
    % (Figure) fig   := figure where to plot
    % (bool)   start := initialize vars to 0 (for runing function first time)
    %
    % Return:
    % ~
    
    % set vars as global so they have 'memory' and don't reset every time
    global distDepth yistDepth prevLat prevLon hDD
    % (double vector) distDepth  := vector containing the distance travelled at each measurement
    % (double vector) yDistDepth := vector containing all the depth of the river bed measurements
    % (double)        prevLat    := previous latitude measurement
    % (double)        prevLon    := previous longitude measurement
    % (GraphPlot)     hDD        := handler for the plot, used for updating the plot
    
    % set start to default value if arg not given
    if ~exist('start', 'var')
        start = false;
    end
    
    % load config
    global param
    
    % if it's first time executing initialize the plot
    if start
        prevLat = lat;
        prevLon = lon;
        
        % add new data to vectors
        % distance  travelled since last data given
        nextd = coord2m(lat, lon, prevLat, prevLon, param.radiusEarth);
        distDepth = [nextd];

        % depth of river bed
        yDistDepth = [pres - dist];

        % plot
        figure(fig)
        hold all

        hDD = plot(distDepth, yDistDepth, param.lineDepthColor);
        
        title('River bed depth along distance traveled');
        xlabel('Distance [m]');
        xtickformat('%.0f')
        ylabel('Depth [m]');
        ylim([param.maxRiverBedDepth 0]);
        xlim([0 1]);

        drawnow;
        
        % update prev values
        prevLat = lat;
        prevLon = lon;
        
        return
    end

    % add new data to vectors
    % distance moved since last data given
    nextd = coord2m(lat, lon, prevLat, prevLon, param.radiusEarth);
    distDepth = [distDepth distDepth(end) + nextd];
    
    % depth of river bed
    yDistDepth = [yDistDepth pres - dist];
    
    % check if max points is reached
    if length(distDepth) > param.maxPlotPoints
        distDepth = distDepth(2:end);
        yDistDepth = yDistDepth(2:end);
    end

    % update plot
    figure(fig)
    set(hDD, 'XData', distDepth, 'YData', yDistDepth)
    xlim([distDepth(1) distDepth(end) + 0.01]);

    drawnow;
    
    % update prev values
    prevLat = lat;
    prevLon = lon;
end
