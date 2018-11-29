function Main()
    X = 0:0.1:10;
    Y = X .* sin(X.^2 - X .* 5);
%     try_net(X, Y, 20);
    try_net(X, Y, 50);
end

function try_net(X, Y, layers)
    net = feedforwardnet(layers);
    net = configure(net, X, Y);

    net.trainParam.epochs = 1000;
    net.trainParam.max_fail = 100;
    net.trainParam.mu_dec = 0.001;
    net.trainParam.mu_inc = 3.0;

    net = train(net, X, Y);
    outputs = net(X);
    show_performance(X, Y, outputs);
end

function show_performance(X, Y, outputs)
    figure(1); plot(X, Y, X, outputs, '-r','MarkerSize',6,'LineWidth', 2);

    errors = outputs - Y;
    figure(2); plot(errors);
end