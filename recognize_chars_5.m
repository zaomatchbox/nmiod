clear; clc; clf;

[alphabet, targets] = prprob;

IN = alphabet;
OUT = targets;

net = feedforwardnet(26);

net.performFcn = 'sse';
net.trainParam.show = 20;
net.trainParam.epochs = 5000;
net.trainParam.time = Inf;
net.trainParam.goal = 0.01;
net.trainParam.min_grad = 1e-10;
net.trainParam.max_fail = 50;
net.trainParam.lr =  0.005;

net.divideFcn = '';

net = train(net, IN, OUT);

letterF = alphabet(:, 6);
figure, plotchar(letterF);

net2 = net;

numNoise = 30;
INn = min(max(repmat(IN, 1, numNoise) + randn(90, 26 * numNoise) * 0.2, 0),1);
OUTn = repmat(OUT, 1, numNoise);

net2 = train(net2, INn, OUTn);
net2 = train(net2, IN, OUT);
%%
noiseLevels = 0:.05:1;
numLevels = length(noiseLevels);
percError1 = zeros(1,numLevels);
percError2 = zeros(1,numLevels);
for i = 1:numLevels
  Xtest = min(max(repmat(IN,1,numNoise)+randn(90,26*numNoise)*noiseLevels(i),0),1);
  Y1 = net(Xtest);
  percError1(i) = sum(sum(abs(OUTn-compet(Y1))))/(26*numNoise*2);
  Y2 = net2(Xtest);
  percError2(i) = sum(sum(abs(OUTn-compet(Y2))))/(26*numNoise*2);
end

figure
plot(noiseLevels,percError1*100,'--',noiseLevels,percError2*100);
title('Percentage of Recognition Errors');
xlabel('Noise Level');
ylabel('Errors');
legend('Network 1','Network 2','Location','NorthWest')