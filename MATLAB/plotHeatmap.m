function plotHeatmap(pres, dist, lat, lon, fig, ax, start)
    % This function plots and updates the heatmap, where:
    % - x     := longitude
    % - y     := latitude
    % - color := depth of the river
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
    global xlon ylat zcol hH
    % (double vector) xlon := vector containing all the measurements of longitude
    % (double vector) ylat := vector containing all the measurements of latitude
    % (double matrix) zcol := vector containing rgb values for the depth
    % (GraphPlot)     hH   := handler for the plot, used for updating the plot
    
    % set star to default value if arg not given
    if ~exist('start', 'var')
        start = false;
    end
    
    % load config
    global param
   
    % if it's the first time executing initialize the plot
    if start
        depth = pres-dist;  % pres is negative dist is positive

        % map AND bound depth from (0 to -7 m) to (1 to 256)
        % because param.colormap is a 256 element array
        color = floor(255*depth/param.maxRiverBedDepth) + 1;
        color = max(1, min(color, 256));
        rgb = param.colormap(color, 1:3);

        % initialize data vectors
        xlon = [lon lon];
        ylat = [lat lat];
        zcol = [rgb; rgb];
        
        % plot
        figure(fig)
        hold all

        hH = scatter(xlon, ylat, param.dotSize, zcol, 'filled');
        title('Heatmap of the River');
        xlabel('Longitude [º]');
        ylabel('Latitude [º]');

        % set colorbar location and range
        colormap(param.colormap)
        colorbar('Location', 'EastOutside')
        caxis(ax, [param.maxRiverBedDepth param.surface])

        drawnow;

        return
    end
    
    depth = pres-dist;  % pres is negative dist is positive
    
    % map AND bound depth from (0 to -7) to (1 to 256)
    color = 256 - floor(255*depth/param.maxRiverBedDepth);
    color = max(1, min(color, 256));
    rgb = param.colormap(color, 1:3);
    
    % update data
    xlon = [xlon lon];
    ylat = [ylat lat];
    zcol = [zcol; rgb];
    
    % check if max points is reached, if reached pop first element
    if length(xlon) > param.maxPlotPoints
        xlon = xlon(2:end);
        ylat = ylat(2:end);
        zcol = zcol(2:end);
    end
    
    % plot
    figure(fig)
    set(hH, 'XData', xlon, 'YData', ylat, 'CData', zcol)
    
    drawnow;
end

