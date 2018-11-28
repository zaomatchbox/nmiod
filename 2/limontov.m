function Main()
    disp('Solving for loqical AND');
    X_train = {[0; 0] [0; 1] [1; 0] [1; 1]};
    Y_train = {0, 0, 0, 1};
    X_test = X_train;
    Y = build_logiql(X_train, Y_train, X_test, [0 1; 0 1], 1);
    % Output:
    Y

    disp('Solving for loqical OR');
    X_train = {[0; 0] [0; 1] [1; 0] [1; 1]};
    Y_train = {0, 1, 1, 1};
    X_test = X_train;
    Y = build_logiql(X_train, Y_train, X_test, [0 1; 0 1], 1);
    % Output:
    Y

    disp('Solving for loqical NAND');
    X_train = {[0; 0] [0; 1] [1; 0] [1; 1]};
    Y_train = {1, 1, 1, 0};
    X_test = X_train;
    Y = build_logiql(X_train, Y_train, X_test, [0 1; 0 1], 1);
    % Output:
    Y

    disp('Solving for loqical NOR');
    X_train = {[0; 0] [0; 1] [1; 0] [1; 1]};
    Y_train = {1, 0, 0, 0};
    X_test = X_train;
    Y = build_logiql(X_train, Y_train, X_test, [0 1; 0 1], 1);
    % Output:
    Y

    disp('Solving for loqical XOR');
    X_train = {[0; 0] [0; 1] [1; 0] [1; 1]};
    Y_train = {0 1 1 0};
    X_test = X_train;
    Y = build_logiql(X_train, Y_train, X_test, [0 1; 0 1], 2);
    Y
% 
%     disp('Solving for loqical NXOR');
%     X_train = {[0; 0] [0; 1] [1; 0] [1; 1]};
%     Y_train = {1, 0, 0, 1};
%     X_test = X_train;
%     Y = build_logiql(X_train, Y_train, X_test, [0 1; 0 1; 0 1; 0 1], 2);
%     Y
end

function [Y_test] = build_logiql(X_train, Y_train, X_test, inputs, neurons)
%     declaring a network with two inputs [0, 1] interval each
    net = newp(inputs, neurons);
    net.adaptParam.passes = 20;
    net = train(net, X_train, Y_train);
    Y_test = sim(net, X_test);
end