function Main() 
    range = -1:0.1:1;
    N = size(range, 2);

    a = -1; b = -1; c = -1; d = 1; e = 1; f = 1;

    [x1, x2] = meshgrid(range, range);
    x1 = reshape(x1, 1, []);
    x2 = reshape(x2, 1, []);

    Y = a*(x1.^2) + b*(x2.^2) + c*x1.*x2 + d*x1 + e*x2 + f;
    show_surf(1, x1, x2, Y, N);

%     net = feedforwardnet();
%     try_net(net, x1, x2, Y, N);
    
    net = feedforwardnet(2, 'traingdx');
    try_net(net, x1, x2, Y, N);
end

function try_net(net, x1, x2, Y, N)
    net = configure(net, [x1; x2], Y);

    net.trainParam.epochs = 1000;
    net.trainParam.goal = 0.01;
    net.trainParam.min_grad = 1e-06;

    net = train(net, [x1; x2], Y);
    outputs = net([x1; x2]);
    
    show_surf(2, x1, x2, outputs, N);

    errors = outputs - Y;
    figure(3); plot(errors);
end

function show_surf(fignum, x1, x2, y, N)
    figure(fignum); 
    surf(reshape(x1, N, N), reshape(x2, N, N), reshape(y, N, N));
end
