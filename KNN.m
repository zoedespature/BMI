close all;

load('monkeydata_training.mat')


%%
X = zeros(800, 98)
Y = zeros(800, 1)

trial_id = 0
Y = zeros(800, 1)
fire_rates = zeros(800, 98)
for movement = 1:8
    for trial_num = 1:100
        trial_id = trial_id + 1;
        for neuron = 1:98
            count = 0;
            for i = 1:300
                if trial(trial_num, movement).spikes(neuron, i) == 1
                    count = count + 1;
                end
            end
            fire_rates(trial_id, neuron) = count;
            Y(trial_id, 1) = movement;
        end
    end
end