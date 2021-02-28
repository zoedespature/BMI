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
nbins               = 20;       % divide range of values into nbins intervals, count how many values fall into each interval
h                   = histogram(spks,nbins);    % create histogram
h.FaceColor         = 'k';                      % change color of histogram to black

title('Post Stimulus Time Histogram (PTSH)');
xlabel('Time (ms)');
ylabel('spike count');

%% Tuning curve

figure;
fire_rates = zeros(8,100);

% plot(trial(1,1).spikes(4,:))

for movement = 1:8

    for trial_num = 1:100

    count = 0;

        for i = 1:length(trial(trial_num,1).spikes)

            if trial(trial_num,1).spikes(movement,i) == 1

                count = count + 1;

            end

        end

    fire_rates(movement, trial_num) = count;

    end

end

fire_rates = transpose(fire_rates);

avg_fire_rate = mean(fire_rates);

figure;

plot(avg_fire_rate);


%% Population vector algorithm

fire_rates = zeros(100,8);

avg_fire_rates = zeros(98, 8);

% plot(trial(2,3).spikes(1,:))

for neuron = 1:98

    for movement = 1:8

        for trial_num = 1:100

        count = 0;

            for i = 1:length(trial(trial_num,movement).spikes)

                if trial(trial_num,movement).spikes(neuron,i) == 1

                    count = count + 1;

                end

            end

        fire_rates(trial_num, movement) = count;

        end

    end

    avg_fire_rate = mean(fire_rates);

    avg_fire_rates(neuron, :) = avg_fire_rate;

 

end

figure;
hold on
for i = 1:8
    plot(avg_fire_rates(:, i));
end

legend('Movement 1', 'Movement 2', 'Movement 3', 'Movement 4', 'Movement 5', 'Movement 6', 'Movement 7', 'Movement 8');
