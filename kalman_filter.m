T = 600;


A_1 = [];
A_2 = [];

for t = 2:T
    A_1 = A_1 + x(t)*x(t-1)' ; 
    A_2 = A_2 + x(t-1)*x(t-1)' ; 
end

A = A_1 * A_2 ;

% Time update equations (prediction of the a priori state estime x_hat_)
x_hat_(t) = A*x_hat(t-1);
V_(t) = A*V(t-1)*A' + W;

% Measurement update equations update the estimate with the new measurement
% data)

% Q measurement error matrix
% H Q A W are estimated in the encoding stage
% x_hat(t-1) V(t-1) are estimated state and uncertainty at t-1
K(t) = V_(t) * H' * inv(H * V_(t) * H' + Q) ;

x_hat(t) = x_hat_(t) + K(t)*(y(t) - H*x_hat_(t));
V(t) = (I - K(t)*H)*P_(t);


