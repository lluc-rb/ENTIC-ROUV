function [lon, lat, pres, dist] = parser(dataString)
    % This function parses the recieved data package and returns the values as doubles
    %
    % Args:
    % (String) dataString := data package recieved from the ROUV
    %
    % Return
    % (double) lon  := longitude value
    % (double) lat  := latitude value
    % (double) pres := pressure value
    % (double) dist := distance value

    % Load config file
    global param
    
    % Get the diferent data values
    data = split(dataString, param.separator);

    % Calculate depth of the submarine
    % y = m*x + n
    pres = param.mPres*str2double(data(1)) + param.nPres;
    
    % Calculate distance of the sensor
    dist = str2double(data(2))/100;
    
    % Get gps values
    if length(data) > 3
        % valid GPS
        [lon, lat] = parseGPS(data(3), data(4));
    else
        % invalid GPS (data(3) = 'X')
        [lon, lat] = parseGPS(data(3));
    end
end
