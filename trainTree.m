%% Training Side
% random three class data with target matrix -- [9X3] 9 observation with 3 features

data = [];
target = [];

for iMovement = 1:size(trial,2)
    for iTrial = 1:length(trial)
        for iNeuron = 1:size(trial(iTrial,iMovement).spikes,1)
            
            data = [data ; sum(trial(iTrial,iMovement).spikes(iNeuron,1:100)) sum(trial(iTrial,iMovement).spikes(iNeuron,101:200)) sum(trial(iTrial,iMovement).spikes(iNeuron,201:300))];
            
            target = [target ; iMovement]; 
            
        end
    end
end


%% Create a decision tree

dtree = fitctree(data,target); % dtree is the trained model. save it at end for doing testing
save('dtree.mat','dtree');

% train performance
label = predict(dtree,data);
perf=sum(label==target)/size(label,1) % performance in the range of 0 to 1

%% Testing Side
% for testing load the trained model
load('dtree.mat');
testdata = [sum(trial(1,3).spikes(25,1:100)) sum(trial(1,3).spikes(25,101:200)) sum(trial(1,3).spikes(25,201:300))]; % take 1 new unknown observation and give to trained model
Group = predict(dtree,testdata);