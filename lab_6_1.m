P = [2 1 -1 5 3];
T = [-2 -1 0 1 2];
spread = 0.4;

net = newgrnn(P, T, spread);

U = net(P);
Q = net(-2:0.3:5);

plot(P, T, 'o', P, U, 'o', -2:0.3:5, Q, 'linewidth', 2);
legend('Real','Simulated','Range Simulated','Location','NorthWest');