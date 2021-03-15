function [x, y] = positionEstimator(test_data, modelParameters)

  % **********************************************************
  %
  % You can also use the following function header to keep your state
  % from the last iteration
  %
  % function [x, y, newModelParameters] = positionEstimator(test_data, modelParameters)
  %                 ^^^^^^^^^^^^^^^^^^
  % Please note that this is optional. You can still use the old function
  % declaration without returning new model parameters. 
  %
  % *********************************************************

  % - test_data:
  %     test_data(m).trialID
  %         unique trial ID
  %     test_data(m).startHandPos
  %         2x1 vector giving the [x y] position of the hand at the start
  %         of the trial
  %     test_data(m).decodedHandPos
  %         [2xN] vector giving the hand position estimated by your
  %         algorithm during the previous iterations. In this case, N is 
  %         the number of times your function has been called previously on
  %         the same data sequence.
  %     test_data(m).spikes(i,t) (m = trial id, i = neuron id, t = time)
  %     in this case, t goes from 1 to the current time in steps of 20
  %     Example:
  %         Iteration 1 (t = 320):
  %             test_data.trialID = 1;
  %             test_data.startHandPos = [0; 0]
  %             test_data.decodedHandPos = []
  %             test_data.spikes = 98x320 matrix of spiking activity
  %         Iteration 2 (t = 340):
  %             test_data.trialID = 1;
  %             test_data.startHandPos = [0; 0]
  %             test_data.decodedHandPos = [2.3; 1.5]
  %             test_data.spikes = 98x340 matrix of spiking activity
  
  
  
  % ... compute position at the given timestep.
  
  % Return Value:
  
  % - [x, y]:
  %     current position of the hand
  
    
    for neuron = 1:size(test_data.spikes,1)
        count = 0;
        
        for i = 1:300
            if test_data.spikes(neuron, i) == 1
                count = count + 1;
            end
        end

        X(neuron) = count;
            
    end
  
  label = predict(modelParameters.knn, X);
  
  t = size(test_data.spikes,2);
  
  if isnan(modelParameters.mean_movements_x(label,t))
      x = modelParameters.mean_movements_x(label,600);
      y = modelParameters.mean_movements_y(label,600);
  elseif isnan(modelParameters.mean_movements_y(label,t))
      x = modelParameters.mean_movements_x(label,600);
      y = modelParameters.mean_movements_y(label,600);
  else
      x = modelParameters.mean_movements_x(label,t);
      y = modelParameters.mean_movements_y(label,t);
  end
  

end
