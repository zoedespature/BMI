close all;

load('monkeydata_training.mat');

%% Concatenated histograms


figure;

for iTrial = 1:length(trial)

    spks = [];      % Spks array is created outside of for loop to gather all the time stamps at which neural unit 1 fired through every trial

    for iNeuralUnit = 1:size(trial(iTrial,2).spikes,1)    % For loop which goes from the first trial of a movement til the last one (1 to 100)

        for i = 1:length(trial(iTrial,2).spikes)        % For loop to go through the array of the first neural unit of each trial
            if trial(iTrial,2).spikes(iNeuralUnit,i) == 1         % If loop which detects when the unit fired (when its =1)
                spks = [spks i];                        % Add the time stamp at which the unit fired to the spks array
            end
        end

    end

    subplot(98,1,iNeuralUnit);

    nbins               = 3;       % divide range of values into nbins intervals, count how many values fall into each interval
    h                   = histogram(spks,nbins);    % create histogram
    h.FaceColor         = 'k';                      % change color of histogram to black
    xlim([0, 1000]);

end
