close all;

load('monkeydata_training.mat');

%% Peristimulus time histogram (PSTH)

spks = [];      % Spks array is created outside of for loop to gather all the time stamps at which neural unit 1 fired through every trial

for iTrial = 1:length(trial)    % For loop which goes from the first trial of a movement til the last one (1 to 100)
    
    for i = 1:length(trial(iTrial,1).spikes)        % For loop to go through the array of the first neural unit of each trial
        if trial(iTrial,1).spikes(1,i) == 1         % If loop which detects when the unit fired (when its =1)
            spks = [spks i];                        % Add the time stamp at which the unit fired to the spks array
        end
    end
    
end

figure;
nbins               = 3;       % divide range of values into nbins intervals, count how many values fall into each interval
h                   = histogram(spks,nbins);    % create histogram
h.FaceColor         = 'k';                      % change color of histogram to black

% [N,edges] = histcounts(spks, 'Normalization','pdf');
% edges = edges(2:end) - (edges(2)-edges(1))/2;
% plot(edges, N);

title('Post Stimulus Time Histogram (PTSH)');
xlabel('Time (ms)');
ylabel('spike count');