load('monkeydata_training.mat')

%%

X = trial(1, 1).handPos(1:2,:);
X_1 = X(:, 1:end-1);
X_2 = X(:, 2:end);
Y = trial(1,1).spikes(1,:);

A = X_2 * X_1' * inv(X_1 * X_1');

H = Y * X' * inv( X * X');

Q = (X_2 - A*X_1) * transpose(X_2 - A*X_1)./(length(X) -1) 

R = (Y - H*X) * transpose(Y - H*X)./(length(X))

%%
xhat(:, 1) = [-13.47; -8.02]
P = zeros(2,2)

for k = 2:length(Y)
    xbar(:,k) = A*xhat(:, k-1)
    Pbar =  A * P * A' + Q
    K = Pbar * H' * inv(H * Pbar * H' + R)
    
    
    XX = xbar(:, k) + K * (Y(k) - H * xbar(k));
    
    
    xhat(:, k) = XX(:,1);
    
    
%     (eye(size(K,1)) - K * H) * Pbar
    
    P = (eye(size(K,1)) - K * H) * Pbar'
end

%%
figure
hold on

plot(xhat(1,:), xhat(2,:))

plot(trial(1,1).handPos(1,:),trial(1,1).handPos(2,:)) 