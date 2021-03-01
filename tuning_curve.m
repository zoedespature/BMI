close all;

load('monkeydata_training.mat');

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

