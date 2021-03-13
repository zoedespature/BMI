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
x_bar = zeros(2,672);


x = trial(Movement, Trial).handPos(1:2,:);
X_1 = x(:, 1:end-1);
X_2 = x(:, 2:end);

A = zeros(s,s);     % sxs state transition matrix
A = X_2 * X_1' * inv(X_1 * X_1');

H = zeros(n,s);  % nxs observation matrix
H = Y * x' * inv( x * x');

Q = ((X_2 - A * X_1) * (X_2 - A * X_1)')./(n-1);
R = ((Y - H * x) * (Y - H * x)')/n;

x_hat(k) = x_bar(k) + K(k) * (Y(k) - H * x_bar(k));
x_bar(k) = A*x_hat(k-1);
P_bar(k) = A * P(k-1) * A' + Q(k);

w = randn([s,1]);
v = randn([n,1]);

P_bar(k) = (x(k) - x_bar(k)) * (x(k) - x_bar(k))';
K(k) = P_bar(k) * H' * inv(H * P_bar(k) * H' + R);
P(k) = (eye(s) - K(k) * H) * P_bar(k);

x(k+1) = A * x(k) + w(k);
Y(k) = H * x(k) + v(k);

