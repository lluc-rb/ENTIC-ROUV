function plotTimePres(t, pres, fig, start)
    % This function plots and updates the plot for the depth of the ROUV along time
    % this function is not used, we are using plotTimePresDepth instead
    % - x := time of each measurement
    % - y := depth of the ROUV
    %
    % Args:
    % (double) t     := time of the measurement
    % (double) pres  := depth of the ROUV
    % (Figure) fig   := figure where to plot
    % (bool)   start := initialize vars to 0 (for runing function first time)
    %
    % Return:
    % ~
    
    % set t and y as global so they have 'memory' and dont reset every time
    % the function is called
    global tTimePres yTimePres hTP
    % (double vector) tTimePres := vector containing the time of each measurement
    % (double vector) yTimePres := vector containing the measurements of the depth of the ROUV
    
    % set start to default value if arg not given
    if ~exist('start', 'var')
        start = false;
    end
    
    % load config
    global param
    
    % if it's first time executing initialize vars (t, y)
    if start
        tTimePres = [-param.secWidth:param.Tsampling:0];
        yTimePres = zeros(1, length(tTimePres));
        
        tTimePres = [tTimePres(2:end) t];
        yTimePres = [yTimePres(2:end) pres];

        % plot
        figure(fig)
        hTP = plot(tTimePres, yTimePres);
        hold on
        set(hTP, 'Color', param.lineROUVColor)
        
        title('ROUV depth');
        xlabel('Time [s]');
        ylabel('Depth [m]');
        ylim([param.maxROUVDepth 0]);
        xlim([tTimePres(1) tTimePres(end)]);
        drawnow;
        
        return
    end

    % add new data to vectors
    tTimePres = [tTimePres(2:end) t];
    yTimePres = [yTimePres(2:end) pres];

    % plot
    figure(fig)
    set(hTP, 'XData', tTimePres, 'YData', yTimePres)
    xlim([tTimePres(1) tTimePres(end)])

    drawnow;
end
