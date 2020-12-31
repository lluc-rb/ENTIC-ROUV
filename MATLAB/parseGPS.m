function [lat, lon] = parseGPS(lat, lon)
    % This function parses the gps data and returns the values as double,
    % if lat is equal to param.formatGPS return the previous lat and lon values
    %
    % (String) lat := string containing the revieved gps data corresponding to latitude
    % (String) lon := string containing the revieved gps data corresponding to longitude

    % set vars as global so they have 'memory' and don't reset every time
    global pLat pLon
    % (double) pLat := previous latittude value
    % (double) pLon := previous longitude value
   
    % load config
    global param 
    
    % set lon to none
    if ~exist('lon', 'var')
        lon = param.invalidGPS;
    end
    
    if strcmp(lat, param.invalidGPS)
        lat = pLat;
        lon = pLon;
        
        return
    end
    
    % get the two values
    lat = extractAfter(lat, param.formatGPSLAT);
    lon = extractAfter(lon, param.formatGPSLON);
    
    % transform to double
    lat = str2double(lat);
    lon = str2double(lon);
    
    pLat = lat;
    pLon = lon;
end

