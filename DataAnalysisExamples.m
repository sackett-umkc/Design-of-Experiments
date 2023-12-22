%% Creating a script with comments and sections
close all; clear all; clc;

%% Setting a Working Directory / Adding to Path
addpath("./data");

%% variables vs. Matrices vs. Structures vs. Tables (not looking at cell arrays but those are fun too)
A=5;
B=[1,2,3;4,5,6;7,8,9];

%structures support nested data
s.a=A;
s.b=B;

%Tables are basically spreadsheets
mltab = table();
mltab.alpha = [1;2;3];
mltab.beta = [4;5;6];
%% Exporting Data to Excel
writetable(mltab,'./data/example_in_excel.xlsx');
%% Loading an excel table
newtab = readtable('./data/example_in_excel.xlsx');
%% Creating a Plot
%   load the data
nominal = load("./data/qube_out_nominal.mat");

%%  create figure
close(figure(1)) %closing so we can iterate
figure(1)
plot(nominal.pend(:,1),nominal.pend(:,2))
hold on; %so we can keep plotting on this figure
plot(nominal.yaw(:,1),nominal.yaw(:,2))
grid on;
legend('Pendulum','Yaw')

%% That isn't pretty enough... lets beautify it a bit
close(figure(1)) %closing so we can iterate
figure(1)
s2= subplot(2,1,1)
plot(nominal.pend(:,1),nominal.pend(:,2),'.')
hold on; %so we can keep plotting on this figure
xlabel('Sample #')
ylabel('Angle (deg)')
title('Pendulum Angle vs. Sample')
grid on;
s1= subplot(2,1,2)
plot(nominal.yaw(:,1),nominal.yaw(:,2),'k.')
xlabel('Sample #')
ylabel('Angle (deg)')
title('Yaw Angle vs. Sample')
grid on;
legend('Pendulum','Yaw')

%lets link the axes as well
linkaxes([s1,s2],'x')

%% Creating a Logical Index (Feature Engineering 101)
%lets look at the steep negative areas of slope
pdot=deriv(nominal.pend(:,2),nominal.pend(1,1)-nominal.pend(2,1));
figure(2)
plot(nominal.pend(:,1),pdot) %just to confirm it works

ind=pdot<-50;
hold on;
plot(nominal.pend(ind,1),pdot(ind),'.')


%% Updating your plot with your feature
figure(1)

subplot(2,1,1)
hold on;
plot(nominal.pend(ind,1),nominal.pend(ind,2),'bx')


%% More complex feature with derivatives and mutliple datasets
subplot(2,1,2)
hold on;
plot(nominal.yaw(ind,1),nominal.yaw(ind,2), 'ro')


%% Include Qube Command
close(figure(1)) %closing so we can iterate
command = load("./data/qube_command.mat");
com=command.sig';

pend = nominal.pend(1:30000,:);
yaw = nominal.yaw(1:30000,:);
figure(1)
s1 = subplot(3,1,1)
plot(com(:,1),com(:,2));
xlabel('Sample #')
ylabel('Command Angle (deg)')
title('Command Signal')
s2= subplot(3,1,2)
plot(pend(:,1),pend(:,2),'.')
hold on; %so we can keep plotting on this figure
xlabel('Sample #')
ylabel('Angle (deg)')
title('Pendulum Angle vs. Sample')
grid on;
s3= subplot(3,1,3)
plot(yaw(:,1),yaw(:,2),'k.')
xlabel('Sample #')
ylabel('Angle (deg)')
title('Yaw Angle vs. Sample')
grid on;
legend('Pendulum','Yaw')

%lets link the axes as well
linkaxes([s1,s2,s3],'x')
