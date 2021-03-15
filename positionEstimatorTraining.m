function [modelParameters] = positionEstimatorTraining(trainingData)
  % Arguments:
  
  % - training_data:
  %     training_data(n,k)              (n = trial id,  k = reaching angle)
  %     training_data(n,k).trialId      unique number of the trial
  %     training_data(n,k).spikes(i,t)  (i = neuron id, t = time)
  %     training_data(n,k).handPos(d,t) (d = dimension [1-3], t = time)
  
  % ... train your model
  
  % Return Value:
  
  % - modelParameters:
  %     single structure containing all the learned parameters of your
  %     model and which can be used by the "positionEstimator" function.
  
  
modelParameters = struct();


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

modelParameters.knn = fitcknn(X,Y);


% Calculating mean

mean_movements_x = zeros(8,1000);

for iMovement = 1:size(trainingData,2)

    mean_trial = zeros(length(trainingData),1000);

        for iTrial = 1:length(trainingData)

            for iTime = 1:size(trainingData(iTrial,iMovement).handPos)

            mean_trial(iTrial,:) = [trainingData(iTrial,iMovement).handPos(1,:) zeros(1,1000-length(trainingData(iTrial,iMovement).handPos))];
            

            end

        end
        
    mean_trial(mean_trial == 0) = NaN;

    mean_trial = mean(mean_trial, 'omitnan');

    mean_trial = mean_trial(1, 1:1000);
    
    mean_movements_x(iMovement,:) = mean_trial;
    
end

mean_movements_y = zeros(8,1000);

for iMovement = 1:size(trainingData,2)

    mean_trial = zeros(length(trainingData),1000);

        for iTrial = 1:length(trainingData)

            for iTime = 1:size(trainingData(iTrial,iMovement).handPos)

            mean_trial(iTrial,:) = [trainingData(iTrial,iMovement).handPos(2,:) zeros(1,1000-length(trainingData(iTrial,iMovement).handPos))];
            
            
            end

        end
        
    mean_trial(mean_trial == 0) = NaN;
    
    mean_trial = mean(mean_trial, 'omitnan');

    mean_trial = mean_trial(1, 1:1000);
    
    mean_movements_y(iMovement,:) = mean_trial;
    
end

modelParameters.mean_movements_x = mean_movements_x;
modelParameters.mean_movements_y = mean_movements_y;

  
end
