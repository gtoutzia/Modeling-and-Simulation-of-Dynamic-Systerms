%Toutziaris Georgios AEM 10568
%mixed structure estimation
clc;
clf;
close all;
%f = @(x) (1/2) * x * sin(x);
f = @(x) -(1/4) * x^2;

th1 = 0.5;
th2 = 2;

am=1;
g1=20;
g2=20;

u = @(t) 1.5 * sin(2 *pi* t)*exp(-3*t);
t = 0:0.1:20;
odefun = @(t,x) [-th1*f(x(1)) + th2*u(t);
                         -g1*(x(1)-x(4))*f(x(1));
                          g2*(x(1)-x(4))*u(t);
                         -x(2)*f(x(1))+x(3)*u(t)+am*(x(1)-x(4))];
     
[t,x] = ode45(odefun,t,[0,0,0,0]);

%x and x_pred 
figure()
hold on;
plot(t,x(:,1));
plot(t,x(:,4));
hold off
grid on;
xticks(0:5:60)
title('[Mixed structure] $x$ and $\hat{x}$ without noise','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x$','$\hat{x}$','interpreter','latex','FontSize',25);


     
% e = x - x_pred 
figure()
plot(t,x(:,1)- x(:,4));
title('[Mixed structure] e = $x$ - $\hat{x}$ without noise','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
grid on;
xticks(0:5:60)


% theta1 and theta2 
figure()
subplot(2,1,1)
hold on;
plot(t,x(:,2));
yline(0.5,'r');
hold off
title({'[Mixed structure] $theta1$ and $\hat{theta1}$'},'interpreter','latex','FontSize',20);
xlabel('Time [s]','FontSize',15);
grid on;
xticks(0:5:60)

subplot(2,1,2)
hold on;
plot(t,x(:,3));
yline(2,'r');
hold off
title({'[Mixed structure] $theta2$ and $\hat{theta2}$'},'interpreter','latex','FontSize',20);
xlabel('Time [s]','FontSize',15);
grid on;
xticks(0:5:60)