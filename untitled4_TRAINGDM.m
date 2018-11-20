clc; clf; clear

X = -1:0.1:1;
Y = X;
P = [X; Y];
P = num2cell(P, 1);
T = sin(X .^ 2) ./ cos(Y .^ 2);
T = num2cell(T, 1);

net = feedforwardnet(2, 'traingdm');
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';

net.trainParam.show = 100;
net.trainParam.lr = 0.015;
net.trainParam.goal = 1e-004; 
net.trainParam.mc =0.9;

tic
[net] = train(net, P, T);
toc

A = sim(net, P);
e = cell2mat(A) - cell2mat(T);
mse(e)
[x, y] = meshgrid(X, Y);
z = sin(x .^ 2) ./ cos(y .^ 2);
figure(1), clf; surf(x, y, z);
a = cat(1, A{:});
[a] = meshgrid(a);
figure(2), clf; surf(x, y, a);