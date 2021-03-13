close all;
clear all;

load('monkeydata_training.mat')

%% Selection of 10 neurons with the highest firing rate
close all;
clear all;

load('monkeydata_training.mat')

% Calculate baseline firing

for neuron = 1:98
    for movement = 1:8
        for trial_num = 1:100
        count_pre = 0;
            for i = 1:300
                if trial(trial_num,movement).spikes(neuron,i) == 1
                    count_pre = count_pre + 1;
                end
            end
        count_pre = count_pre*2/3; %spikes per 200 ms 
        fire_rates_pre(trial_num, movement) = count_pre; 
        end
    end
    avg_fire_rate_pre = mean(fire_rates_pre);
    avg_fire_rates_pre_movement(neuron, :) = avg_fire_rate_pre;
end

% spike rate of neuron during movement when subtracting the baseline firing

for neuron = 1:98
    for movement = 1:8
        for trial_num = 1:100
        count_during = 0;
            for j = 301:500
                if trial(trial_num,movement).spikes(neuron,j) == 1
                    count_during = count_during + 1;
                end
            end
        fire_rates_during(trial_num, movement) = count_during - count_pre;
        end
    end
    avg_fire_rate_during = mean(fire_rates_during);
    avg_fire_rates_during_movement(neuron, :) = avg_fire_rate_during;
end

% out is the avg firing rate of the neurons sorted from lowest to hight and
% idx is their original index aka the neuron numbers 

[out, idx]=sort(avg_fire_rates_during_movement);

%%
% without substracting

% for neuron = 1:98
%     for movement = 1:8
%         for trial_num = 1:100
%         count_d = 0;
%             for j = 301:500
%                 if trial(trial_num,movement).spikes(neuron,j) == 1
%                     count_d = count_d + 1;
%                 end
%             end
%         fire_rates_d(trial_num, movement) = count_d;
%         end
%     end
%     avg_fire_rate_d = mean(fire_rates_d);
%     avg_fire_rates_d_movement(neuron, :) = avg_fire_rate_d;
% end
