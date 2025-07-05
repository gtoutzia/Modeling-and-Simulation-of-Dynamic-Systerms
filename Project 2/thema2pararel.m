%Toutziaris Georgios AEM 10568
clc;
clf;
close all;

main(0.5,40);
main(1,50);
main(2,60);
main(5,80);
main(10,120);

function main(h0,f)
% Define system parameters
a = 2;
b = 5;

g1=20;
g2=20;

u = @(t) 5 * sin(2 * t);
h= @(t) h0*sin(2*pi*f*t);
% Time span
t = 0:0.1:20;

%Estimation wihtout noise
odefun1 = @(t,x) [-a*x(1)+ b*u(t);
                     -g1*(x(1)-x(4))*x(4);
                      g2*(x(1)-x(4))*u(t);
                      -x(2)*x(4)+x(3)*u(t)];
%Estimation with noise
odefun2 = @(t,x) [-a*x(1)+ b*u(t);
                     -g1*(x(1)+h(t)-x(4))*x(4);
                      g2*(x(1)+h(t)-x(4))*u(t);
                     -x(2)*x(4)+x(3)*u(t)];
[t,x] = ode45(odefun1,t,[0,0,0,0]);
[t,x_noise] = ode45(odefun2,t,[0,0,0,0]);

%x and x_pred with and without noise
figure()
subplot(2,1,1)
hold on;
plot(t,x(:,1));
plot(t,x(:,4));
hold off
grid on;
xticks(0:5:60)
title('[Parallel structure] $x$ and $\hat{x}$ without noise','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x$','$\hat{x}$','interpreter','latex','FontSize',25);


subplot(2,1,2)
hold on;
plot(t,x_noise(:,1));
plot(t,x_noise(:,4));
hold off
grid on;
xticks(0:5:60)
title({'[Parallel structure] $x$ and $\hat{x}$ with noise';['f =',num2str(f),', h0 =',num2str(h0)]},'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
legend('$x$','$\hat{x}$','interpreter','latex','FontSize',25);

% e = x - x_pred with and without noise
figure()
subplot(2,1,1)
plot(t,x(:,1)- x(:,4));
title('[Parallel structure] e = $x$ - $\hat{x}$ without noise','interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
grid on;

subplot(2,1,2)
plot(t,x_noise(:,1)- x_noise(:,4));
title({'[Parallel structure] e = $x$ - $\hat{x}$ with noise';['f =',num2str(f),', h0 =',num2str(h0)]},'interpreter','latex','FontSize',25);
xlabel('Time [s]','FontSize',15);
grid on;

% a and b with and without noise
figure()
subplot(2,1,1)
hold on;
plot(t,x_noise(:,2));
plot(t,x(:,2));
yline(2,'-k');
hold off
title({'[Parallel structure] a and $\hat{a}$ with and without noise';['f =',num2str(f),', h0 =',num2str(h0)]},'interpreter','latex','FontSize',20);
legend('$\hat{a}$ with noise','$\hat{a}$ without noise','$a_{real}$','interpreter','latex');
xlabel('Time [s]','FontSize',15);
grid on;

subplot(2,1,2)
hold on;
plot(t,x_noise(:,3));
plot(t,x(:,3));
yline(5,'-k');
hold off
title({'[Parallel structure] b and $\hat{b}$ with and without noise';['f =',num2str(f),', h0 =',num2str(h0)]},'interpreter','latex','FontSize',20);
legend('$\hat{b}$ with noise','$\hat{b}$ without noise','$b_{real}$','interpreter','latex');
xlabel('Time [s]','FontSize',15);
grid on;
end