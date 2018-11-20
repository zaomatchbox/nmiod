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

net.biases{1,1}.learnFcn='learngdm';
net.biases{2,1}.learnFcn='learngdm';
net.layerWeights{2,1}.learnFcn='learngdm';
net.inputWeights{1,1}.learnFcn='learngdm';
net.layerWeights{2,1}.learnParam.lr = 0.015;
net.inputWeights{1,1}.learnParam.lr = 0.015;
net.adaptParam.passes = 200;

[net, A, e, Pf, Af] = adapt(net, P, T);

tic
for i=1:300
    [net, A, e, Pf, Af] = adapt(net, P, T, Pf, Af);
end
toc

A = sim(net, P);
mse(e)
[x, y] = meshgrid(X, Y);
z = sin(x .^ 2) ./ cos(y .^ 2);
figure(1), clf; surf(x, y, z);
a = cat(1, A{:});
[a] = meshgrid(a);
figure(2), clf; surf(x, y, a);