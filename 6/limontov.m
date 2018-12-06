function Main()
    P = [2 -1 1 -1 2];
    T = [-1 1 1 1 3];
    spread = 0.4;
    try_func(spread, P, T, -3:0.1:4);
    
    net = newgrnn(P, T, spread);
    
    U = net(P);
    Q = net(-2:0.1:5);
    plot(P, T, 'o', P, U, 'o', -2:0.1:5, Q, 'linewidth', 2);
    legend('Real', 'Simulated', 'Range Simulated', 'Location', 'NorthWest');
    
    x = [-4:0.2:4];
    w_noise = 0.1;
    y = sin(x) + cos(x) + randn(size(x)) * w_noise;
    spread = 0.6;
    x_pred = [-4:0.1:4];
    try_func(spread, x, y, x_pred);

    x_range = [0:0.05:1];
    Nx = size(x_range, 2);
    y_range = [-2:0.15:1];
    Ny = size(y_range, 2);
    N = Nx;
    [x, y] = meshgrid(x_range, y_range);
    T = exp(x) + 3 .* y;
    
    show_surf(1, x, y, T, N);
    title('Initial');
    
    spread = 0.01;
    net = newrbe(x, y, spread);
    y_pred = net(x);
    show_surf(2, x, y_pred, T, N);
    title('Predicted');
end

function show_surf(fignum, x1, x2, y, N)
    figure(fignum); 
    surf(reshape(x1, N, N), reshape(x2, N, N), reshape(y, N, N));
end

function try_func(spread, x, y, x_pred)
    net = newgrnn(x, y, spread);
    y_pred = net(x_pred);
    size(x)
    size(y)
    size(x_pred)
    size(y_pred)
    plot(x, y, 'o', x_pred, y_pred, 'x');
    legend('Initial values', 'Predicted values');
    title(sprintf('With SPREAD=%.2f', spread));
end