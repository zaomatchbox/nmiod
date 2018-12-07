function Main()
%     try_1()
%     try_2()
    try_3()
end

function try_1()
    scale = 0.2;
    P = [
        randn(1, 10) * scale 1 + randn(1, 15) * scale 2 + randn(1, 20) * scale; 
        randn(1, 10) * scale 1 + randn(1, 15) * scale 2 + randn(1, 20) * scale
    ]
    net = newc([1; 1], 2); % создание слоя;
    net = train(net,P); % обучение слоя;
    w = net.Iw{1,1}; % веса после обучения;
    b = net.b{1}; % смещение после обучения; 
    gensim (net); % структура слоя;
    plot(P(1,:),P(2,:),'+k');
    title ('Векторы входа'),xlabel('P(1,:)'), ylabel('P(2,:)');
    hold on;
    plot (w, 'or'), plot(b, '*');
    
    P1 = [0.1:0.1:2.2; 0.1:0.1:2.2];
    y = sim(net, P1);
    yc = vec2ind(y)
    figure(2);
    plot(P(1,:), P(2,:), '+k');
    hold on
    plot(P1(1,:), P1(2,:), '*')
    title ('Векторы входа'),xlabel('P(1,:)'), ylabel('P(2,:)')
end

function try_2()
    angels=0 : 0.5*pi/99 : 0.5*pi;
    P=[sin(angels); cos(angels)];
    net=newsom([0 1 ;0 1], 10);
    net.trainparam.epochs=2000;
    net.trainparam.show=100;
    [net,tr]=train(net,P);
    plot(P(1, 1:10:end), P(2, 1:10:end), '*r');
    hold on
    plotsom(net.iw{1,1}, net.layers{1}.distances)
    a=sim(net,[1;0])
    b=sim(net,[0;1])
end

function try_3()
    P = [
        -0.8 -0.6 -0.55 -0.52 -0.38 0.4 -0.6 0.5 -0.2 -0.2 -0.2 -0.1 -0.05 0.05 0.08 0.08 0.07 0.2;
        -0.9 -0.75 -0.8 -0.79 -0.8 -0.9 0.4 0.2 -0.1 -0.3 -0.5 -0.3 -0.25 0.0 0.3 0.41 1 -0.1
    ];
%     net = newc([1; 1], 2); % создание слоя;
%     net = train(net,P); % обучение слоя;
%     w = net.Iw{1,1}; % веса после обучения;
%     b = net.b{1}; % смещение после обучения; 
%     gensim (net); % структура слоя;
%     plot(P(1,:),P(2,:),'+k');
%     title ('Векторы входа'),xlabel('P(1,:)'), ylabel('P(2,:)');
%     hold on;
%     plot (w, 'or'), plot(b, '*');
%     
%     P1 = [-1:0.05:0; -1:0.1:1];
%     y = sim(net, P1);
%     yc = vec2ind(y)
%     figure(2);
%     plot(P(1,:), P(2,:), '+k');
%     hold on
%     plot(P1(1,:), P1(2,:), '*')
%     title ('Векторы входа'),xlabel('P(1,:)'), ylabel('P(2,:)')

    net=newsom([0 1 ;0 1], 5);
    net.trainparam.epochs=2000;
    net.trainparam.show=100;
    [net,tr]=train(net,P);
    plot(P(1, :), P(2, :), '*r');
    hold on
    plotsom(net.iw{1,1}, net.layers{1}.distances)
end