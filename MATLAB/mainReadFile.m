close all; clear all; clc;
% This script reads the data from a file instead of the ROUV

tic
% tester file has incorrect invalid coords
% lat range [-90 90]
% lon range [-180 180]
fName = 'tester.txt';

% load config parameters
global param
param = config();

% open reader file
fprintf("Opening file %s!\n", fName);
readFile = fopen(fName, 'r');

% create and open save file
if param.saveData
    writeFile = fopen(param.saveFile, 'w+');
end

% set initial time
c0 = fix(clock);
t0 = 3600*c0(4) + 60*c0(5) + c0(6);

% data reception and plotting
fig = figure();
first = true;
while ~feof(readFile)
    keyPressed = get(fig, 'CurrentCharacter');
    % if the s key is pressed the plotting will stop and the script terminated
    if keyPressed == 's'
        break;
    end
    
    % check if new line is available
    dataString = fgetl(readFile);
    
    % if EOF reached break
    if ~ischar(dataString), break, end

    % parse data
    [lon, lat, pres, dist] = parser(dataString);
   
    % get next t
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
    dataString
    % plot heatmap
    h = subplot(2,2,2);
    plotHeatmap(pres, dist, lat, lon, fig, h)
    
    % save data if option enabled
    if param.saveData
        fprintf(writeFile, );
    end
    
    % show data if option enabled
    if param.showData
        fprintf(param.formatShowData, pres, dist, lat, lon);
    end    
end

% finish script execution
if param.saveData
    fprintf("Saving data in file %s\n", param.saveFile)
    fclose(writeFile);
end

fprintf("Closing file %s!\n", fName);
fclose(readFile);
toc
