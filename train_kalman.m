clear all
clc

load('monkeydata_training.mat')

%%
[coeff, score] = pca(trial(1,1).spikes(:,:))
red = score(:, 1)

X = []
X_1 = []
X_2 = []
Y = []
for n = 1:100
    X = [X, trial(n, 1).handPos(1:2,:)];
    X_1 = [X_1, trial(n, 1).handPos(1:2,1:end-1)];
    X_2 = [X_2, trial(n, 1).handPos(1:2,2:end)];
    Y = [Y, red'*trial(n,1).spikes(:,:)];
end
    


%%
% [coeff, score] = pca(trial(1,1).spikes(:,:))
% red = score(:, 1)
% Y = red'*trial(1,1).spikes(:,:)
% 
% X = trial(1, 1).handPos(1:2,:);
% X_1 = X(:, 1:end-1);
% X_2 = X(:, 2:end);
% Y = trial(1,1).spikes(:,:);

A = X_2 * X_1' * inv(X_1 * X_1');

H = Y * X' * inv( X * X');

Q = (X_2 - A*X_1) * transpose(X_2 - A*X_1)./(length(X) -1) 

R = (Y - H*X) * transpose(Y - H*X)./(length(X))

%%
xhat(:, 1) = [-13.47; -8.02]
P{1} = zeros(2,2)

for k = 2:length(Y)
    xbar(:,k) = A*xhat(:, k-1);
    Pbar =  A * P{k-1} * A' + Q;
    K = Pbar * H' * inv(H * Pbar * H' + R);
    
    xhat(:, k) = xbar(:, k) + K * (Y(:,k) - H * xbar(:,k));
    
    
%     (eye(size(K,1)) - K * H) * Pbar
    
    P{k} = (eye(size(K,1)) - K * H) * Pbar';
end


%%
xhat(:, 1) = [-13.9806, -9.0345]
P{1} =  zeros(2,2)
Y = red'*trial(3,1).spikes(:,:)

for k = 2:length(Y)
    xbar(:,k) = A*xhat(:, k-1);
    Pbar =  A * P{k-1} * A' + Q;
    K = Pbar * H' * inv(H * Pbar * H' + R);
    
    xhat(:, k) = xbar(:, k) + K * (Y(:,k) - H * xbar(:,k));
    
    
%     (eye(size(K,1)) - K * H) * Pbar
    
    P{k} = (eye(size(K,1)) - K * H) * Pbar';
end

%%
figure
hold on
plot(trial(3,1).handPos(1,:),trial(3,1).handPos(2,:))
plot(xhat(1,:), xhat(2,:))


%%
[coeff, score] = pca(trial(1,1).spikes(:,:))
red = score(:, 1)

yy= trial(1,1).spikes(:,:)
x_train = red'*trial(1,1).spikes(:,:)
