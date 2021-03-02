close all;

load('monkeydata_training.mat');

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

