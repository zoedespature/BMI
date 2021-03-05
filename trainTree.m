%% Training Side
% random three class data with target matrix -- [9X3] 9 observation with 3 features

data = [sum(trial(1,1).spikes(7,1:100)) sum(trial(1,1).spikes(7,101:200)) sum(trial(1,1).spikes(7,201:300));
        sum(trial(1,1).spikes(33,1:100)) sum(trial(1,1).spikes(33,101:200)) sum(trial(1,1).spikes(33,201:300));
        sum(trial(1,1).spikes(45,1:100)) sum(trial(1,1).spikes(45,101:200)) sum(trial(1,1).spikes(45,201:300));
        sum(trial(1,2).spikes(7,1:100)) sum(trial(1,2).spikes(7,101:200)) sum(trial(1,2).spikes(7,201:300));
        sum(trial(1,2).spikes(33,1:100)) sum(trial(1,2).spikes(33,101:200)) sum(trial(1,2).spikes(33,201:300));
        sum(trial(1,2).spikes(45,1:100)) sum(trial(1,2).spikes(45,101:200)) sum(trial(1,2).spikes(45,201:300));
        sum(trial(1,3).spikes(7,1:100)) sum(trial(1,3).spikes(7,101:200)) sum(trial(1,3).spikes(7,201:300));
        sum(trial(1,3).spikes(33,1:100)) sum(trial(1,3).spikes(33,101:200)) sum(trial(1,3).spikes(33,201:300));
        sum(trial(1,3).spikes(45,1:100)) sum(trial(1,3).spikes(45,101:200)) sum(trial(1,3).spikes(45,201:300));];
target = [1;1;1;2;2;2;3;3;3];
% create a decision tree
dtree = fitctree(data,target,'MinParentSize',2); % dtree is the trained model. save it at end for doing testing
save('dtree.mat','dtree');
% train performance
label = predict(dtree,data);
perf=sum(label==target)/size(label,1) % performance in the range of 0 to 1

%% Testing Side
% for testing load the trained model
load('dtree.mat');
testdata = [sum(trial(1,1).spikes(7,1:100)) sum(trial(1,1).spikes(7,101:200)) sum(trial(1,1).spikes(7,201:300))]; % take 1 new unknown observation and give to trained model
Group = predict(dtree,testdata);