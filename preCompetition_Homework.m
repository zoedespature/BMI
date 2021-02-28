close all;

load('monkeydata_training.mat');

%% Raster plot

figure;
hold on
y = 0;
for iTrial = 1:98
    
    spks = [];
    for i = 1:672
        if trial(1,1).spikes(iTrial,i) == 1
            spks = [spks i];
        end
    end
    
%     spks         = trial(1,1).spikes(iTrial,:);         % Replicate array
    xspikes = repmat(spks,3,1);
    yspikes      	= nan(size(xspikes));       % NaN array
    
    if ~isempty(yspikes)
        yspikes(1,:) = iTrial-1;                % Y-offset for raster plot
        yspikes(2,:) = iTrial;
    end
%     
%     plot(trial(1,1).spikes(iTrial,:)+y);
    plot(yspikes, xspikes, 'Color', 'k');
%     y=y+1;

end

title('Raster plot for one neural unit over many trials');


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
fire_rates = zeros(8,100)

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

avg_fire_rate = mean(fire_rates)

figure;

plot(avg_fire_rate);


