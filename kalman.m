%% Steady state Kalman Filter
% Approximates the optimal time varying KF gain with with a matrix that
% represents the steady state value of the filter gain

% We have s kinematic states and n firing rates observations 

Movement = 1;   % change for dynamic
Trial = 1;      % change for dynamic
k=1;
Y = trial(1,1).spikes(1,:);

s = size(trial,2);
n = length(trial(Movement,Trial).spikes);
x_est = zeros(2,672);

x = trial(Movement, Trial).handPos(1:2,:);
X_1 = x(:, 1:end-1);
X_2 = x(:, 2:end);

A = zeros(s,s);     % sxs state transition matrix
A = X_2 * X_1' * inv(X_1 * X_1');

H = zeros(n,s);  % nxs observation matrix
H = Y * x' * inv( x * x');

w = randn([s,1]);
v = randn([n,1]);

P_est(k) = (x(k) - x_est(k)) * (x(k) - x_est(k))';
K(k) = P_est(k) * H' * inv(H * P_est(k) * H' + R);
x_hat(k) = x_est(k) + K(k) * (y(k) - H * x_est(k));
P(k) = (eye(s) - K(k) * H) * P_est(k);

x(k+1) = A * x(k) + w(k);
y(k) = H * x(k) + v(k);

x_est(k) = A*h_hat(k-1);
P_est(k) = A * P(k-1) * A' + Q;