function Main()
    [alphabet, T] = prprob;
%     plotchar(alphabet(:,6));

    [output_layer_size, Q] = size(T);
    hidden_layer_size = 10;
    net = newff(alphabet, T, [hidden_layer_size output_layer_size], {'logsig' 'logsig'}, 'traingdx');
    net.LW{2,1} = net.LW{2,1}*0.01;
    net.b{2} = net.b{2}*0.01;

    net.performFcn = 'sse';
    net.trainParam.goal = 0.1;
    net.trainParam.show = 20;
    net.trainParam.epochs = 5000;
    net.trainParam.mc = 0.95;
    [net,tr] = train(net, alphabet, T);

    noised_n = net;
    [R,Q] = size(alphabet);
    noised_n.trainParam.goal = 0.6;
    noised_n.trainParam.epochs = 300;
    TT = [T T T T];
    P = [alphabet, alphabet, (alphabet + randn(R,Q)*0.1), (alphabet + randn(R,Q)*0.2)];
    [noised_n,tr] = train(noised_n,P,TT);
    
    for pass = 1:45
        P = [alphabet, alphabet, (alphabet + randn(R,Q)*0.1), (alphabet + randn(R,Q)*0.2)];
        [noised_n,tr] = train(noised_n,P,TT);
    end
    
    try_letter(noised_n, alphabet, 1);
    err_find(net, noised_n, alphabet, T);
end

function try_letter(net, alphabet, letter)
    noised_letter = alphabet(:,letter) + randn(35,1) * 0.1;
    figure(1); plotchar(noised_letter);
    letter = sim(net, noised_letter);
    answer = find(compet(letter) == 1)
    figure(2); plotchar(alphabet (:,answer));
end


% noise_range = 0:.05:.5; max_test = 100; network1 = []; network2 = [];
% T = targets;
% for noiselevel = noise_range fprintf('Уровень шума %.2f.\n',noiselevel); errors1 = 0;
%     errors2 = 0;
%     for i = 1:max_test
%         P = alphabet + randn(35,26)*noiselevel;
%         % Тест для сети 1
%         A = sim(net,P);
%         AA = compet(A);
%         errors1 = errors1+sum(sum(abs(AA-T)))/2;
%         % Тест для сети 2
%         An = sim(noised_n,P);
%         AAn = compet(An);
%         errors2 = errors2+sum(sum(abs(AAn-T)))/2;
%     end
%     network1 = [network1 errors1/26/100]; % среднее значения ошибок (100 последовательностей из 26 векторов)
%     network2 = [network2 errors2/26/100]; % среднее значения ошибок (100 последовательностей из 26 векторов)
% end

% net.trainParam.goal = 0.1;
% net.trainParam.epochs = 500;
% net.trainParam.show = 5;
% [net, tr] = train(net, P, T);
% 
% 

% noised1 = alphabet(:,1) + randn(35,1) * 0.2;
% noised2 = alphabet(:,2) + randn(35,1) * 0.4;
% noised3 = alphabet(:,3) + randn(35,1) * 0.8;
% plotchar(noised1);
% plotchar(noised2);
% plotchar(noised3);


% letter = sim(net, noisyD);
%  answer = find(compet(letter) == 1)
%  plotchar(alphabet (:,answer));
% letter = sim(net, noisyI);
%  answer = find(compet(letter) == 1)
%  plotchar(alphabet (:,answer));
% letter = sim(net, noisyM);
%  answer = find(compet(letter) == 1)
%  plotchar(alphabet (:,answer));
% letter = sim(net, noisyA);
%  answer = find(compet(letter) == 1)
%  plotchar(alphabet (:,answer));
%  
%  
function err_find(net, noised_n, alphabet, T)
    noise_range = 0:.05:.5;
    max_test = 100;
    network1 = [];
    network2 = [];
    for noiselevel = noise_range
     errors1 = 0;
     errors2 = 0;
     for i = 1:max_test
     P = alphabet + randn(35,26)*noiselevel;
     A = sim(net,P);
     AA = compet(A); 
     errors1 = errors1+sum(sum(abs(AA-T)))/2;
     An = sim(noised_n,P);
     AAn = compet(An);
     errors2 = errors2+sum(sum(abs(AAn-T)))/2;
     end
     network1 = [network1 errors1/26/100];
     network2 = [network2 errors2/26/100];
    end
    figure(3);
    plot(noise_range,network1*100,'--',noise_range,network2*100);
    title('#Errors');
    xlabel('Noise');
    ylabel('Network 1 - - Network 2 ---');
end