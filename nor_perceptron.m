clear;clc;

net = newp([0 1; 0 1], 1);
P = [0 0 1 1;
     0 1 0 1];
T = [1 0 0 0];

net(P);
net.trainParam.epochs = 20;
net = train(net, P, T);

Y = net(P);

Y