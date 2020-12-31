function param = config()
    % This function returns and object with the configuration values as arguments

    % misc
    param.saveData = true;
    param.saveFile = sprintf("%d-%d-%d_%d-%d-%.0f", clock) + ".dat";
    param.showData = true;
    param.formatShowData = "Depth: %1.2f m; Distance: %1.2f m; Latitude: %3.6fº; Longitude: %3.6fº;\n";
    param.maxPlotPoints = 1000;
    param.radiusEarth = 6371e3; % in meters
    
    
    % serial
    param.serialPort = 'COM10';
    param.baudRate = 9600;
    param.terminator = 'CR/LF';
    
    % limits
    param.surface = 0;
    param.maxROUVDepth = -3;
    param.maxRiverBedDepth = -7;
    param.secWidth = 20;
    
    % transsmission info
    param.fsampling = 5;
    param.Tsampling = 1/param.fsampling;
    
    % plot info
    param.lineDepthColor = 'b';
    param.lineROUVColor = 'r';
    param.colormap = jet;
    param.dotSize = 20;

    % pressure info
    param.maxPresInt = 840;
    param.minPresInt = 600;
    param.mPres = (param.maxROUVDepth - param.surface)/(param.maxPresInt - param.minPresInt);
    param.nPres = param.surface - param.mPres*param.minPresInt;
    
    % data format
    param.separator = ";";
    param.separatorGPS = ';';
    param.invalidGPS = 'X';
    param.formatGPSLAT = "LAT=";
    param.formatGPSLON = "LON=";
    param.formatGPS = param.formatGPSLAT + "%f" + param.separatorGPS + param.formatGPSLON + "%f";
    
    % pressure;ultrasoundDist;GPS
    param.dataFormat = "%d" + param.separator + "%f" + param.separator + param.formatGPS;
end

