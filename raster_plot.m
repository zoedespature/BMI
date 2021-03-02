close all;

load('monkeydata_training.mat');

%% Raster plot


for iMovement = 1:size(trial,2)
    
    figure;
    hold on     % retains plots so that new plots added to the axes do not delete existing plots

    for iTrial = 1:length(trial)    % For loop which goes from the first trial of a movement til the last one (1 to 100)

        spks = [];                  % Creating an empty array which will contain the time stamp of each spike
        for iTime = 1:length(trial(iTrial,iMovement).spikes)        % For loop to go through the array of the first neural unit of each trial
            if trial(iTrial,iMovement).spikes(1,iTime) == 1         % If loop which detects when the unit fired (when its =1)
                spks = [spks iTime];                        % Add the time stamp at which the unit fired to the spks array
            end
        end

        xspikes = repmat(spks,2,1);         % Make an array with two rows of the timestamps
        yspikes = zeros(size(xspikes));     % Create an array with same dimensions as xspikes filled with zeroes
                                            % Will be the indexes where plot has to draw a vertical line

        yspikes(1,:) = iTrial-1;            % Index of lower bound
        yspikes(2,:) = iTrial;              % Index of higher bound


        plot(xspikes, yspikes, 'Color', 'k');   % Will plot a straight line between lower and higher bound of yspikes, at times indicated by xspikes

    end

    title(['Raster plot for neural unit ', num2str(1), ' over many trials, movement ', num2str(iMovement)]);
    xlabel('Time (ms)');
    ylabel('Trial number');

end