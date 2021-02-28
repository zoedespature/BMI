close all;

load('monkeydata_training.mat');

%% Raster plot

figure;
hold on     % retains plots so that new plots added to the axes do not delete existing plots


for iTrial = 1:length(trial)    % For loop which goes from the first trial of a movement til the last one (1 to 100)
    
    spks = [];                  % Creating an empty array which will contain the time stamp of each spike
    for i = 1:length(trial(iTrial,1).spikes)        % For loop to go through the array of the first neural unit of each trial
        if trial(iTrial,1).spikes(1,i) == 1         % If loop which detects when the unit fired (when its =1)
            spks = [spks i];                        % Add the time stamp at which the unit fired to the spks array
        end
    end
    
    xspikes = repmat(spks,2,1);         % Make an array with two rows of the timestamps
    yspikes = zeros(size(xspikes));     % Create an array with same dimensions as xspikes filled with zeroes
                                        % Will be the indexes where plot has to draw a vertical line
    
    yspikes(1,:) = iTrial-1;            % Index of lower bound
    yspikes(2,:) = iTrial;              % Index of higher bound
                                        

    plot(xspikes, yspikes, 'Color', 'k');   % Will plot a straight line between lower and higher bound of yspikes, at times indicated by xspikes

end

title('Raster plot for one neural unit over many trials');
xlabel('Time (ms)');
ylabel('Trial number');


%% Peristimulus time histogram (PSTH)
spks = [];

for iTrial = 1:98
    
    for i = 1:672
        
        if trial(1,1).spikes(iTrial,i) == 1
            spks = [spks i];
        end
        
    end
    
end

figure;
nbins               = 20;
h                   = histogram(spks,nbins);
h.FaceColor         = 'k';

mVal                = max(h.Values)+round(max(h.Values)*.1);

XLabel.String  	= 'Time [s]';
YLabel.String  	= 'Spikes/Bin';

slength             = 500;                                  % Length of signal trace [ms]
bdur                = slength/nbins;                        % Bin duration in [ms]
nobins              = 1000/bdur;                            % No of bins/sec
for iLab = 1:length(YTickLabel)
    lab             = str2num(ax.YTickLabel{iLab});
    conv            = (lab / length(sptimes)) * nobins; 	% Convert to [Hz]: avg spike count * bins/sec
    newlabel{iLab}  = num2str(round(conv));                 % Change YLabel
end
YTickLabel       = newlabel;
YLabel.String  	= 'Firing Rate [Hz]';

[f,xi] = ksdensity(spks);
hold on
plot(xi,f)

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

