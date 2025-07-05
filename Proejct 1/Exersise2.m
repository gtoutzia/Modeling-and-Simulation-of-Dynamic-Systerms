%Toutziaris Georgios AEM 15068
clear;
clc;
close all; 
%set inputs
u1 =@(t) 3*sin(pi*t);
u2 =@(t) 2.5 * ones(1, length(t));

t = 0:0.1:10;
p1 = 110;
p2 = 150;
l1 = p1 +p2;
l2 = p1*p2;
[VR,VC] = v(t);

%Add noise
VC_noise=VC;
VR_noise=VR;
rand_num1 =  randi([1,length(VC)],1,101);
rand_num2 =  randi([1,length(VR)],1,101);
VC_noise(rand_num1) = VC(rand_num1) + 10*VC(rand_num1);
VR_noise(rand_num2) = VR(rand_num2) + 10*VR(rand_num2);
mainVR(VR,'',t,p1,p2,u1,u2);
mainVC(VC,'',t,p1,p2,u1,u2);
mainVR(VR_noise,'noise',t,p1,p2,u1,u2);
mainVC(VC_noise,'noise',t,p1,p2,u1,u2);

function mainVC(VC,noise,t,p1,p2,u1,u2)
    %% Linear transformation using filter for VC
    filter = [1,p1+p2,p1*p2]; %Ë(s) = s^2 + 100s + 110
    sys = tf([-1,0],filter); 
    phi(:,1) = lsim(sys,VC,t);
    sys = tf(-1,filter);
    phi(:,2) = lsim(sys,VC,t);
    sys = tf([1,0],filter);
    phi(:,3) = lsim(sys,u1(t),t);
    sys=tf(1,filter);
    phi(:,4) = lsim(sys,u1(t),t);
    sys=tf([1,0],filter);
    phi(:,5) = lsim(sys,u2(t),t);
    sys=tf(1,filter);
    phi(:,6) = lsim(sys,u2(t),t);   
   
    %% Least Squares Method
    theta = VC*phi/(phi'*phi);
     disp(theta);
    %% Estimated values of VC
    VC_bar = phi*theta';
    %% Plots
    figure();
    hold on;
    plot(t, VC,'LineWidth', 2);
    plot(t,VC_bar);
    hold off;
    title(['VC and ','VC', '_{bar} ',noise]);
    xlabel('time');
    ylabel('V');
    legend('VC',['VC','_{bar}']);
    grid on;
    
    e = VC - VC_bar;
    figure();
    plot(t, e);
    ylabel('e')
    xlabel('t')
    title(['e = ', 'VC', ' - ', 'VC','_{bar} ',noise])
    grid on;
end

function mainVR(VR,noise,t,p1,p2,u1,u2)    
%% Linear transformation using filter for VC
    filter = [1,p1+p2,p1*p2]; %Ë(s) = s^2 + 100s + 110
    sys = tf([-1,0],filter); 
    phi(:,1) = lsim(sys,VR,t);
    sys = tf(-1,filter);
    phi(:,2) = lsim(sys,VR,t);
    sys = tf([1,0,0],filter);
    phi(:,3) = lsim(sys,u1(t),t);
    sys=tf([1,0],filter);
    phi(:,4) = lsim(sys,u1(t),t);
    sys=tf(1,filter);
    phi(:,5) = lsim(sys,u1(t),t);
    sys=tf([1,0,0],filter);
    phi(:,6) = lsim(sys,u2(t),t); 
    sys=tf([1,0],filter);
    phi(:,7) = lsim(sys,u2(t),t);
    sys=tf(1,filter);
    phi(:,8) =lsim(sys,u2(t),t);
    
    %% Least Squares Method
    theta = VR*phi/(phi'*phi);
    disp(theta');
    %% Estimated values of VC
    VR_bar = phi*theta';
    %% Plots
    figure();
    hold on;
    plot(t, VR,'LineWidth', 2);
    plot(t,VR_bar);
    hold off;
    title(['VR and ','VR', '_{bar} ',noise]);
    xlabel('time');
    ylabel('V');
    legend('VR',['VR','_{bar}']);
    grid on;
    
    e = VR - VR_bar;
    figure();
    plot(t, e);
    ylabel('e')
    xlabel('t')
    title(['e = ', 'VR', ' - ', 'VR','_{bar} ',noise])
    grid on;
end