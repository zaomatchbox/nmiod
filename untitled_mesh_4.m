clc; clear; clf;

range = -1:0.1:1;
N = size(range, 2);

a = 1; b = 1; c = 1; d = 1; e = 1; f = 1;
[X, Y] = meshgrid(range, range);
X = reshape(X, 1, []);
Y = reshape(Y, 1, []);
Z = a * X .^ 2 + b * Y .^ 2 + c * X .* Y + d * X + e * Y + f;

IN = [X; Y];
OUT = Z;

figure(1); surf(reshape(X, N, N), reshape(Y, N, N), reshape(Z, N, N));

net = feedforwardnet(10);
net = configure(net, IN, OUT);

net.trainParam.epochs = 1000;
net.trainParam.max_fail = 10;
net.trainParam.min_grad = 1e-05;

net = train(net, IN, OUT);

PREDICT = net(IN);

figure(2); surf(reshape(IN(1,:), N, N), reshape(IN(2,:), N, N), reshape(PREDICT, N, N));

ERR = PREDICT - OUT;

mse(ERR)
figure(3); plot(ERR);