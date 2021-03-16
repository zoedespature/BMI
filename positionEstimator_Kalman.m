function [decodedPosX,decodedPosY] = positionEstimator(testData,modelParameters)
%POSITIONESTIMATOR Summary of this function goes here
%   Detailed explanation goes here

% Find movement
for neuron = 1:size(testData.spikes,1)
        count = 0;
        
        for i = 1:300
            if testData.spikes(neuron, i) == 1
                count = count + 1;
            end
        end

        X(neuron) = count;
            
end

movement = predict(modelParameters{9}.knn, X);
    
    
xhat(:,1) = testData.startHandPos;
P{1} =  zeros(2,2);

Y = modelParameters{movement}.red'*testData.spikes(:,:);

for k = 2:length(Y)
    xbar(:,k) = modelParameters{movement}.A*xhat(:, k-1);
    Pbar =  modelParameters{movement}.A * P{k-1} * modelParameters{movement}.A' + modelParameters{movement}.Q;
    K = Pbar * modelParameters{movement}.H' * inv(modelParameters{movement}.H * Pbar * modelParameters{movement}.H' + modelParameters{movement}.R);
    
    xhat(:, k) = xbar(:, k) + K * (Y(:,k) - modelParameters{movement}.H * xbar(:,k));
    
    
%     (eye(size(K,1)) - K * H) * Pbar
    
    P{k} = (eye(size(K,1)) - K * modelParameters{movement}.H) * Pbar';
end

decodedPosX=xhat(1,end);

decodedPosY=xhat(2,end);

end

