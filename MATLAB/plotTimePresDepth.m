function plotTimePresDepth(t, pres, dist, fig, start)
    % This function plots and updates the plot for:
    %           - the depth of the ROUV along time
    %           - the depth of the river along time
    %
    % - x  := time of the measurements
    % - y1 := depth of the ROUV
    % - y2 := depth of the river
    %
    % Args:
    % (double) pres  := depth of the ROUV
    % (double) dist  := distance from ROUV to river bed
    % (bool)   start := initialize vars to 0 (for runing function first time)
    % (Figure) fig   := figure where to plot
    %
    % Return:
    % ~
    
    % set t and y as global so they have 'memory' and dont reset every time
    % the function is called
    global tTimeDepth yROUVPos yRBDepth hTPD1 hTPD2
    % (double vector) tTimeDepth := vector containing the time of each measurement
    % (double vector) yROUVPos   := vector containing the depth of the ROUV
    % (double vector) yRBDepth   := vector containint the depth of the river bec
    % (GraphPlot)     hTPD1      := handler for the ROUV depth plot, used for updating the plot
    % (GraphPlot)     hTPD2      := handler for the river bed depth plot, used for updating the plot

    % set start to default value if arg not given
    if ~exist('start', 'var')
        start = false;
    end
    
    % load config
    global param
    
    % if it's first time executing initialize vars (t, y)
    if start
        tTimeDepth = [-param.secWidth:param.Tsampling:0];
        yROUVPos = zeros(1, length(tTimeDepth));
        yRBDepth = yROUVPos;
        
        % add new data to vectors
        tTimeDepth = [tTimeDepth(2:end) t];
        yROUVPos = [yROUVPos(2:end) pres];
        yRBDepth = [yRBDepth(2:end) pres-dist];
       
        % plot
        figure(fig)
        hold all
        
        hTPD1 = plot(tTimeDepth, yROUVPos, param.lineROUVColor);
        hTPD2 = plot(tTimeDepth, yRBDepth, param.lineDepthColor);
        
        title('ROUV depth & river bed depth along time');
        xlabel('Time [s]');
        ylabel('Depth [m]');
        ylim([param.maxRiverBedDepth 0]);
        xlim([tTimeDepth(1) tTimeDepth(end)]);
        legend('ROUV', 'River Bed', 'Location','northwest')
        
        drawnow;
        
        return
    end

    % add new data to vectors
    tTimeDepth = [tTimeDepth(2:end) t];
    yROUVPos = [yROUVPos(2:end) pres];
    yRBDepth = [yRBDepth(2:end) pres-dist];

    % plot
    figure(fig)
    set(hTPD1, 'XData', tTimeDepth, 'YData', yROUVPos)
    set(hTPD2, 'XData', tTimeDepth, 'YData', yRBDepth)
    xlim([tTimeDepth(1) tTimeDepth(end)])A

    drawnow;
end
