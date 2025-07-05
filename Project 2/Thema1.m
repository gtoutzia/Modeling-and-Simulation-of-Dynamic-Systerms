%Toutziaris Georgios AEM 10568
clc;
clf;
close all;

% Define system parameters
a = 4;
b = 1.5;
am = 4.2;
g=20;


%u=@(t)  5;
u = @(t) 5 * sin(2 * t);

% Time span
t = 0:0.1:20;

odefun = @(t,x) [-a*x(1)+b*u(t);
                g*(x(1)-(x(2)*x(4)+x(3)*x(5)))*x(4);
                g*(x(1)-(x(2)*x(4)+x(3)*x(5)))*x(5);
                -am*x(4)+x(1);
                -am*x(5)+u(t);
                -am*x(6) + x(2)*x(6) + x(3)*u(t)];
[t,x] = ode45(odefun,t,[0,0,0,0,0,0]);

a_pred = am - x(:,2);
b_pred = x(:,3);
x_real = x(:,1);
x_pred = x(:,6);
e = x_real - x_pred;

figure()
hold on;
plot(t,x_real);
plot(t,x_pred);
hold off;
grid on;

title('Plot of $x$ and $\hat{x}$','interpreter','latex');
xlabel('Time [s]');
legend('$x$','$\hat{x}$','interpreter','latex');

%plot e = x - x_pred
figure()
plot(t,e)
%xticks(0:5:60)
grid on;
title('e = x - $\hat{x}$','interpreter','latex');
xlabel('Time [s]');
ylabel('e = x - $\hat{x}$','interpreter','latex');

% plot a and b and their predictions
 figure()
hold on
plot(t,a_pred);
plot(t,b_pred,'-r');
yline(4,'--b');
yline(1.5,'--r');
hold off;
grid on;
%xticks(0:5:60)
title('$\hat{a}$ and $\hat{b}$','interpreter','latex');
xlabel('Time [s]');
legend('$\hat{a}$','$\hat{b}$','$a_{real}$','$b_{real}$','interpreter','latex');
