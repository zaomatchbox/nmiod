clc; clear; clf;

range = 0:0.03:10;

IN = range;
OUT = sin(IN .^ 2 - 8 * IN) + 0.2 * randn(size(IN));

net = feedforwardnet(40);
net = configure(net, IN, OUT);

net.trainParam.epochs = 1000;
net.trainParam.max_fail = 100;
net.trainParam.mu_dec = 0.012;
net.trainParam.mu_inc = 5.24;
net.layers{1,1}.transferFcn = 'logsig';
net.layers{2,1}.transferFcn = 'tansig';

net = train(net, IN, OUT);

PREDICT = net(IN);

figure(1); plot(IN, OUT, IN, PREDICT,'-r','MarkerSize',6,'LineWidth', 2);

ERR = PREDICT - OUT;

mse(ERR)
figure(2); plot(ERR);