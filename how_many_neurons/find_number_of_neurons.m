%% Nuwan Dewapriya
%% 2020/12/21
%% This code demonstrates the influence of the number of hidden neurons on the performance of a neural network. 
%% Inputs are the (1) temperature, (2) vacancy concentration, (3) directional constant (related to the loading direction), and (4) strain rate. 
%% The output is the fracture stress of a graphene sample under the 4 input conditions. 

clear all
close all
clc

load('input_target_data.mat')

for hidden_nuron = 1:5
    
    for trial = 1:5
         
        x = input;
        t = target;
       
        % Use Levenberg-Marquardt backpropagation.
        trainFcn = 'trainlm';  
        
        % Create a Neural Net
        hiddenLayerSize = hidden_nuron;
        net = fitnet(hiddenLayerSize,trainFcn);
       
        % Devide of Data for Training, Validation, Testing
        net.divideFcn = 'dividerand';  % Divide randomly
        net.divideMode = 'sample';  % Divide every sample
        net.divideParam.trainRatio = 0.7;
        net.divideParam.valRatio = 0.15;
        net.divideParam.testRatio = 0.15;
       
        % Use Mean Squared Error to evaluate Performance 
        net.performFcn = 'mse';  

        % Training 
        [net,tr] = train(net,x,t);
       
        % Testing
        y = net(x);
       
        % Compute the Test Performance
        testTargets = t .* tr.testMask{1};
        testPerformance = perform(net,testTargets,y);

        mse(trial, hidden_nuron) = testPerformance;
        
    end
    
end

lowest_mse = min(mse);

figure
plot(1:size(lowest_mse,2), lowest_mse,'-.or','MarkerSize',6,'MarkerFaceColor','r')
xlabel('Number of hidden neurons')
ylabel('Mean square error of the test set')
grid on
xticks(1:5)
set(gca,'LineWidth',1,'Fontsize',15)
axis square
