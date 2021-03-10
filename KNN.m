close all;
clear all;

load('monkeydata_training.mat')


%% This code creates the dataset
X = zeros(800, 98)
Y = zeros(800, 1)

trial_id = 0
Y = zeros(800, 1)
X = zeros(800, 98)
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

%%
train_X = X(1:700,:)
train_Y = Y(1:700,:)

test_X = X(701:800, :)
test_Y = Y(701:800, :)


%%
model = fitcknn(train_X,train_Y)

%%
true = 0
for i = 1:100
    label = predict(model, test_X(i, :))
    if label == test_Y(i)
        true = true + 1
    end
end
accuracy = true/100

%%
tree = fitctree(train_X,train_Y)

%%
true = 0
for i = 1:100
    label = predict(tree, test_X(i, :))
    if label == test_Y(i)
        true = true + 1
    end
end
accuracy = true/100