clc
clear all
close all
load('monkeydata_training.mat')

%%

mean_fire_rates = zeros(98);
fire_rates = zeros(98,100)
for trials = 1:100
    for neuron = 1:98
        for movements = 1:8
            count = 0;
            for i = 1:320
                if trial(trials, movements).spikes(neuron, i) == 1
                    count = count+1;
                end
            end 
        end
        fire_rates(neuron, trials)=count;
    end
end

%%
fire_rates = transpose(fire_rates)
mean_fire_rates = mean(fire_rates)
% for i = 1:98
%     
%     mean_fire_rates(2, i) = i
% end

%%
[B, I] = sort(mean_fire_rates)

%%
%Most firing are:
% 36, 68, 88, 77, 75, 4, 96, 81, 85, 7, 87