function model = positionEstimatorTraining(trial)

X = zeros(720, 98);
Y = zeros(720, 1);

trial_id = 0;
Y = zeros(720, 1);
X = zeros(720, 98);
for trial_num = 1:100    
    for movement = 1:8
        trial_id = trial_id + 1;
        for neuron = 1:98
            count = 0;
            for i = 1:300
                if trial(trial_num, movement).spikes(neuron, i) == 1
                    count = count + 1;
                end
            end
            X(trial_id, neuron) = count;
            Y(trial_id, 1) = movement;
        end
    end
end

model = fitcknn(train_X,train_Y);

end