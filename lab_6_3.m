IN = -5:0.1:5;
OUT = sin(IN) + randn(size(IN)) * 0.1;

plot(IN, OUT, '*');
title('Learn batch');
xlabel('IN');
ylabel('OUT');

e = 0.05;
spread = 0.7;

net = newrb(IN, OUT, e, spread);

X = IN;
Y = net(X);

hold on;
plot(X, Y);
hold off;