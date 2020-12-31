close all; clear all; clc;
% This is the main script, run this to recieve and plot the data from the ROUV

% load config parameters
global param
param = config();

% open serial port
fprintf("Opening serial port %s...\n", param.serialPort);
s = serial(param.serialPort, 'BaudRate',param.baudRate, 'Terminator',param.terminator);
fopen(s);

% send start signal
fprintf("Serial port opened.\nSending start signal...\n");
fprintf(s,'%s\n', 'S');
fprintf("Signal sent succesfully!\n\n");

% create and open save file
if param.saveData
    writeFile = fopen(param.saveFile, 'w+');
end

% set default latitude and longitude to 0
global pLat pLon
pLat = 0;
pLon = 0;

% set initial time
c0 = fix(clock);
t0 = 3600*c0(4) + 60*c0(5) + c0(6);

% data reception and plotting
fig = figure();
first = true;
while true
    keyPressed = get(fig, 'CurrentCharacter');
    % if the s key is pressed the plotting will stop and the script terminated
    if keyPressed == 's'
        fprintf("\nSending stop signal to Arduino...\n");
        fprintf(s,'%s\n', 'R');
        fprintf("Signal sent succesfully.\n");
        break;
    end
    
    % read and parse new data
    dataString = fscanf(s, '%s');
    [lon, lat, pres, dist] = parser(dataString);
    
    % calculate the next t
    c = fix(clock);
    t = 3600*c(4) + 60*c(5) + c(6) - t0;
    
    % first time we have to init the different plots
    if first
%         subplot(2,2,1)
%         plotTimePres(t, pres, fig, first)
        subplot(2,2,1)
        plotTimePresDepth(t, pres, dist, fig, first)
        subplot(2,1,2)
        plotDistDepth(pres, dist, lat, lon, fig, first)
        axh = subplot(2,2,2);
        plotHeatmap(pres, dist, lat, lon, fig, axh, first)
        
        first = false;
        continue
    end
    
%     % plot time-press
%     subplot(2,2,1)
%     plotTimePres(t, pres, fig)
    
    % plot time-pres-depth
    subplot(2,2,1)
    plotTimePresDepth(t, pres, dist, fig)
    
    % plot dist-depth
    subplot(2,1,2)
    plotDistDepth(pres, dist, lat, lon, fig)
    
    % plot heatmap
    h = subplot(2,2,2);
    plotHeatmap(pres, dist, lat, lon, fig, h)
    
    % save data if option enabled
    if param.saveData
        fprintf(writeFile, dataString);
    end
   
    % show revieved data if option enabled
    if param.showData
        fprintf(param.formatShowData, pres, dist, lat, lon);
    end 
end

% close serial port
fprintf("Closing Serial port...\n");
fclose(s);
delete(s);
clear s;
fprintf("Port closed succesfully.\n")

% close data file
if param.saveData
    fprintf("Saving data in file %s\n", param.saveFile)
    fclose(writeFile);
end

fprintf("Ending execution...\n")
