% P = [0.10 0.31 0.51 0.72 0.93 1.14 1.34 1.55 1.76 1.96 2.17 2.38 2.59 2.79 3.00];
% T = [0.1010 0.3365 0.6551 1.1159 1.7632 2.5847 3.4686 4.2115 4.6152 4.6095 4.2887 3.8349 3.4160 3.1388 3.0603];
% net = newff([0 3],[4 1],{'tansig' 'purelin'}); 
% gensim(net);
% Y = sim(net,P); 
% figure(1), clf 
% plot(P, T, P, Y, 'o'), grid on
% 
% net.trainParam.epochs = 50; 
% net = train(net, P, T);
% Y = sim(net, P);
% plot(P, T, P, Y, 'o'), grid on
function Main()
%     measure_method('traingd');
%     measure_method('trainrp');
    measure_method('traingdx');
end

function measure_method(method)
    start = tic;
    try_method(method);
    disp('Time');
    disp(toc(start));
end

function output_res(X, Y, Z, T, fig, color)
    Z = cell2mat(Z);
    e = Z - cell2mat(T);
    disp('MSE');
    disp(mse(e));
    
    figure(fig);
    surf(X, Y, Z, 'FaceColor', color);
end

function try_method(method)
    [X,Y] = meshgrid(-2:.2:2, -4:.4:4);
    T = X .* exp(-X.^2 - Y.^2);
    P = [X; Y];
    
    figure(1);
    surf(X,Y,T, 'FaceColor','g');
    P = num2cell(P, 1);
    T = num2cell(T, 1);

    net = feedforwardnet(2, method); 
    net.trainParam.show = 100;
    net.trainParam.lr = 0.001;

    net = train(net, P, T);
    
    Z_predict = sim(net, P);
    output_res(X, Y, Z_predict, T, 2, 'r');
    
    [X,Y] = meshgrid(-1:.1:1, -2:.2:2);
    P = [X; Y];
    P = num2cell(P, 1);
    Z_predict = sim(net, P);
    T = X .* exp(-X.^2 - Y.^2);
    T = num2cell(T, 1);
    output_res(X, Y, Z_predict, T, 3, 'b');
end
