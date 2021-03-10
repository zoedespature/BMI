close all;

load('monkeydata_training.mat')

%%
%Resize the data
for trial_num = 1:100 
    for movement = 1:8
        if length(trial(trial_num,movement).spikes(1,:)) > 800
            trial(trial_num,movement).spikes(1,1:800)
        end
        trial(trial_num, movement).spikes(1, length(trial(trial_num,movement).spikes(1,:))+1:800) = 0
    end
end
%%
% Finds most important neurons before movement (in first 300 ms)
fire_rates = zeros(100,8);

avg_fire_rates_pre_movement = zeros(98, 8);

for neuron = 1:98
    for movement = 1:8
        for trial_num = 1:100
        count = 0;
            for i = 1:300
                if trial(trial_num,movement).spikes(neuron,i) == 1
                    count = count + 1;
                end
            end
        fire_rates(trial_num, movement) = count;
        end
    end
    avg_fire_rate = mean(fire_rates);
    avg_fire_rates_pre_movement(neuron, :) = avg_fire_rate;
end

%%
close all
figure;
hold on
title('Population decoding vector for neuron 7, 33, 41, 91');
ylabel('Avg fire rates pre movement');
xlabel('Movements');
plot(avg_fire_rates_pre_movement(7, :));
plot(avg_fire_rates_pre_movement(33, :));
plot(avg_fire_rates_pre_movement(41, :));
plot(avg_fire_rates_pre_movement(91, :));
legend('Neuron 7', 'Neuron 33', 'Neuron 41', 'Neuron 91')
xticklabels({'movement 1', 'Movement 2', 'Movement 3', 'Movement 4', 'Movement 5', 'Movement 6', 'Movement 7', 'Movement 8'})

