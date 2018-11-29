P = [1 2 3 4 5 6 7 8];
V = [1 1 3 3 2 2 1 1];
T = ind2vec(V);

net = newpnn(P, T);
Y = net(P);
W = vec2ind(Y)
mse(W - V)