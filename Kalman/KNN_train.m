function [knn_modelParameters] = KNN_train(training_data)
%KNN_TRAIN Summary of this function goes here
%   Detailed explanation goes here
    knn_modelParameters = struct();


    % KNN

    trial_id = 0;
    Y = zeros(length(trainingData)*size(trainingData,2), 1);
    X = zeros(length(trainingData)*size(trainingData,2), 98);

    for trial_num = 1:length(trainingData)   

        for movement = 1:size(trainingData,2)

            trial_id = trial_id + 1;

            for neuron = 1:size(trainingData(trial_num, movement).spikes,1)
                count = 0;

                for i = 1:300
                    if trainingData(trial_num, movement).spikes(neuron, i) == 1
                        count = count + 1;
                    end
                end

                X(trial_id, neuron) = count;
                Y(trial_id, 1) = movement;

            end
        end
    end

    knn_modelParameters.knn = fitcknn(X,Y);
end

