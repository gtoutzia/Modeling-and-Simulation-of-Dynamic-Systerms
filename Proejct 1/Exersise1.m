%Toutziaris Georgios AEM 10568
clear;
clc;
close all; 
%% Define system, parameters and input function and simulate system with ode45 
m = 8.5;
b = 0.65;
k = 2;
u = @(t) 10*cos(0.5*pi*t) + 3;
odefun = @(t,y) [y(2); (-b*y(2) - k*y(1) + u(t))/m]; %y(2) and y(1) in state space

t= 0:1e-4:10;

[t,y] = ode45(odefun,t,[0,0]);

Y = y(:,1);
figure()
plot(t,Y)
ylabel('y')
xlabel('t')
title('System output for t=[0,10]s')
grid on;
hold on;
%% Estimate parameters using output of ode45 and the Least Squares Method
filter = [1,4,2]; %Ë(s) = s^2 + 4s + 2
sys = tf([-1,0],filter); 
phi(:,1) = lsim(sys,Y,t);
sys = tf(-1,filter);
phi(:,2) = lsim(sys,Y,t);
sys = tf(1,filter);
phi(:,3) = lsim(sys,u(t),t);

theta = Y'*phi/(phi'*phi);
disp(theta)
%Estimates of m,b,k
mest = 1/theta(3);
best = (theta(1) + 4)*mest;
kest = (theta(2) + 2)*mest;

%ode45 output using the estimates of m,b,k
odefun = @(t,y) [y(2); (-best*y(2) - kest*y(1) + u(t))/mest];

[t,y] = ode45(odefun,t,[0,0]);
Y_bar = y(:,1);
plot(t,Y_bar);
hold off;
legend('Y','Y_{bar}');

%Error function 
error = Y - Y_bar;
figure()
plot(t,error)
ylabel('e')
xlabel('t')
title('error = y - y_{bar}')
grid on;