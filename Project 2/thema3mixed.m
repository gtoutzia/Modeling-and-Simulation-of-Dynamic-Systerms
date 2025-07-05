%Toutziaris Gewrgios AEM 10568
clear;
clc;
close all;

a11 = -1;
a12 = 1;
a21 = -4;
a22 = 0;
b1 = 2;
b2 = 1;

u = @(t)(4*sin(pi*t) + 2*sin(8*pi*t));
t= 0:0.1:40;
theta11 =-5;
theta12 =6;
theta21 =-1;
theta22 =1;

g1= 40;
g2= 20;

[t,x] = ode45(@(t,x)system_equations(t, x, a11, a12, a21, a22, b1, b2, g1, g2,theta11,theta12,theta21,theta22, u),t,[0,0,0,0,0,0,0,0,0,0]);

% plot x1,x2 and x1_pred,x2_pred
figure()
subplot(2,1,1)
hold on;
plot(t,x(:,1));
plot(t,x(:,9));
hold off
grid on;
xticks(0:5:60)
title('[mixed structure] $x_1$ and $\hat{x_1}$','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x_1$','$\hat{x_1}$','interpreter','latex','FontSize',25);

subplot(2,1,2)
hold on;
plot(t,x(:,2));
plot(t,x(:,10));
hold off
grid on;
xticks(0:5:60)
title('[mixed structure] $x_2$ and $\hat{x_2}$','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x_2$','$\hat{x_2}$','interpreter','latex','FontSize',25);

%plot e1 and e2
figure()
subplot(2,1,1)
plot(t,x(:,1)- x(:,9));
title('[mixed structure] $e_1$ = $x_1$ - $\hat{x_1}$','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
grid on;

subplot(2,1,2)
plot(t,x(:,2)- x(:,10));
title('[mixed structure] $e_2$ = $x_2$ - $\hat{x_2}$','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
grid on;

%plot a11,a12,a21,a22
figure()

%a11
subplot(2,2,1)
hold on;
plot(t,x(:,3));
yline(a11,'r');
hold off
title('$a_{11}$ and $\hat{a_{11}}$','interpreter','latex','FontSize',20);
legend('$\hat{a_{11}}$','real $a_{11}$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;

%a12
subplot(2,2,2)
hold on;
plot(t,x(:,4));
yline(a12,'r');
hold off
title('$a_{12}$ and $\hat{a_{12}}$','interpreter','latex','FontSize',20);
legend('$\hat{a_{12}}$','real $a_{12}$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;

%a21
subplot(2,2,3)
hold on;
plot(t,x(:,5));
yline(a21,'r');
hold off
title('$a_{21}$ and $\hat{a_{21}}$','interpreter','latex','FontSize',20);
legend('$\hat{a_{21}}$','real $a_{21}$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;
xticks(0:5:60)

%a22
subplot(2,2,4)
hold on;
plot(t,x(:,6));
yline(a22,'r');
hold off
title('$a_{22}$ and $\hat{a_{22}}$','interpreter','latex','FontSize',20);
legend('$\hat{a_{22}}$','real $a_{22}$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;

%plot b1,b2
figure()
%b1
subplot(2,1,1)
hold on;
plot(t,x(:,7));
yline(b1,'r');
hold off
title('$b_1$ and $\hat{b_1}$','interpreter','latex','FontSize',20);
legend('$\hat{b_1}$','real $b_1$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;


%b2
subplot(2,1,2)
hold on;
plot(t,x(:,8));
yline(b2,'r');
hold off
title('$b_2$ and $\hat{b_2}$','interpreter','latex','FontSize',20);
legend('$\hat{b_2}$','real $b_2$','interpreter','latex');
xlabel('Time [s]','FontSize',12);
grid on;



function dx = system_equations(t, x, a11,a12,a21,a22, b1,b2, gamma1, gamma2, theta11,theta12,theta21,theta22, u)
% x = [y1, y2, a11_hat, a12_hat, a21_hat, a22_hat, b1_hat, b2_hat, y1_hat, y2_hat]
    e(1) = x(1) - x(9);
    e(2) = x(2) - x(10);
    dx(1) = a11 * x(1) + a12 * x(2) + b1 * u(t);
    dx(2) = a21 * x(1) + a22 * x(2) + b2 * u(t);
    dx(3) = gamma1 * e(1) * x(1);
    dx(4) = gamma1 * e(1) * x(2);
    dx(5) = gamma1 * e(2) * x(1);
    dx(6) = gamma1 * e(2) * x(2);
    dx(7) = gamma2 * e(1) * u(t);
    dx(8) = gamma2 * e(2) * u(t);
    dx(9) = x(3) * x(9) + x(4) * x(10) + x(7) * u(t) - (theta11 * e(1) + theta12 * e(2));
    dx(10) = x(5) * x(9) + x(6) * x(10) + x(8) * u(t) - (theta21 * e(1) + theta22 * e(2));
    dx = dx';
end