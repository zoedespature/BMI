function [modelParameters] = positionEstimatorTraining_Kalman(trainingData) 

%POSITIONESTI Summary of this function goes here 

%   Detailed explanation goes here 

  

%     modelParameters = struct() 

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

  

     modelParameters{9}.knn = fitcknn(X,Y); 

     

     

    %Train kalman parameters 

     

    for movement = 1:size(trainingData,2) 

     

    [coeff, score] = pca(trainingData(1,movement).spikes(:,:)); 

    red = score(:, 1:13); 

    modelParameters{movement}.red = red; 

  

%     if movement == 1  

%       [coeff, score] = pca(trainingData(1,1).spikes(:,:)); 

%       red = score(:, 1:5); 

%       modelParameters{movement}.red = red; 

%     end  

%     

%     if movement == 2  

%       [coeff, score] = pca(trainingData(1,2).spikes(:,:)); 

%       red = score(:, 1:9); 

%       modelParameters{movement}.red = red; 

%     end  

%      

%     if movement == 3  

%       [coeff, score] = pca(trainingData(1,3).spikes(:,:)); 

%       red = score(:, 1:7); 

%       modelParameters{movement}.red = red; 

%     end 

%      

%     if movement == 4 

%       [coeff, score] = pca(trainingData(1,4).spikes(:,:)); 

%       red = score(:, 1:4); 

%       modelParameters{movement}.red = red; 

%     end  

%      

%     if movement == 5 

%       [coeff, score] = pca(trainingData(1,5).spikes(:,:)); 

%       red = score(:, 1:6); 

%       modelParameters{movement}.red = red; 

%     end  

%      

%     if movement == 6  

%       [coeff, score] = pca(trainingData(1,6).spikes(:,:)); 

%       red = score(:, 1:18); 

%       modelParameters{movement}.red = red; 

%     end  

%      

%      if movement == 7  

%       [coeff, score] = pca(trainingData(1, 7).spikes(:,:)); 

%       red = score(:, 1:5); 

%       modelParameters{movement}.red = red; 

%      end  

%      

%     if movement == 8 

%       [coeff, score] = pca(trainingData(1,8).spikes(:,:)); 

%       red = score(:, 1:7); 

%       modelParameters{movement}.red = red; 

%     end  

     

    X = []; 

    X_1 = []; 

    X_2 = []; 

    Y = []; 

     

    for n = 1:size(trainingData,1) 

        X = [X, trainingData(n, movement).handPos(1:2,:)]; 

        X_1 = [X_1, trainingData(n, movement).handPos(1:2,1:end-1)]; 

        X_2 = [X_2, trainingData(n, movement).handPos(1:2,2:end)]; 

         

        Y = [Y, red'*trainingData(n,movement).spikes(:,:)]; 

  

    end 

     

    %training parameters 

    modelParameters{movement}.A = X_2 * X_1' * inv(X_1 * X_1'); 

  

    modelParameters{movement}.H = Y * X' * inv(X * X'); 

  

    modelParameters{movement}.Q = (X_2 - modelParameters{movement}.A*X_1) * transpose(X_2 - modelParameters{movement}.A*X_1)./(length(X) -1); 

  

    modelParameters{movement}.R = (Y - modelParameters{movement}.H*X) * transpose(Y - modelParameters{movement}.H*X)./(length(X)); 

  

  

    end 

end 