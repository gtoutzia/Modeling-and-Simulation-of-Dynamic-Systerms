clear;
close all;
clc;

t = 0:1e-4:5;
[Vr,Vc] = v(t);
u1 = @(t) 3*sin(2*t);
u2 = 2;

p1 = 110;
p2 = 150;
l1 = p1 +p2;
l2 = p1*p2;
%% A
%Ë(s) = s^2 + s(p1+p2) +p1p2
denominator = [1, p1+p2, p1*p2];
sys = tf([-1,0],denominator); 
F(:,1) = lsim(sys,Vc,t);
sys = tf(-1,denominator);
F(:,2) = lsim(sys,Vc,t);
sys = tf([1,0],denominator);
F(:,3) = lsim(sys,u1(t),t);
sys = tf(1,denominator);
F(:,4) = lsim(sys,u1(t),t);
sys = tf([1,0],denominator);
F(:,5) = lsim(sys,u2*ones(1,length(t)),t);
sys = tf(1,denominator);
F(:,6) = lsim(sys,u2*ones(1,length(t)),t);

theta = Vc*F/(F'*F);

Vc_bar = F*theta';

figure();
hold on;
plot(t, Vc,'LineWidth', 2);
plot(t,Vc_bar);
hold off;
title('System Output Vc');
xlabel('time');
ylabel('Vc');
legend('Vc','Vc_{bar}');
grid on;


e = Vc' - Vc_bar;
figure();
plot(t, e);
ylabel('e')
xlabel('t')
title('e = y - y_{bar}')
grid on;

fprintf('1/RC = %f\n',theta(1) +l1);
fprintf('1/LC = %f',theta(2) + l2);
