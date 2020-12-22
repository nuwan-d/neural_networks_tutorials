%% Nuwan Dewapriya
%% 2020/12/22
%% Compute the fracture stress of graphene samples using a pre-trained neural network.
%% Plot a figure, which is a part of Fig. 13 in Dewapriya et al. Carbon, vol. 163, 2020, pp. 425-440.
%% Inputs are the temperature and vacancy concentration. 

close all;
clear all;
clc

%% Load data

load('neural_net.mat')
load('inputs.mat')
load('md_results.mat')

%% Simulate the network

y = sim(net,x);

%% Compare the outputs with molecular dynamics results

figure
plot(md_results(:,2), md_results(:,3),'ro','MarkerSize',5,'MarkerEdgeColor','r','LineWidth',1)
hold on
plot(md_results(:,2), y','-.bs','MarkerSize',4,'MarkerEdgeColor','b','LineWidth',1)

set(gca,'LineWidth',1,'Fontsize',9)
set(gca,'FontName','Arial')

xlabel('Vacancy Concentration (%)','FontName','Arial','fontsize',10)
ylabel('Fracture Stress (GPa)','FontName','Arial','fontsize',10) 
grid off
axis('square')

legend({'Molecular Dynamics', 'Neural network'},'Location','northeast','FontSize',9)
legend boxoff
