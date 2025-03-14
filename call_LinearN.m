% call_LinearN_01.m
% General single-track linear model of an articulated vehicle
% Function articABCD builds the state space matrices
%
% example here is a Nordic combination with data from: 
% Kharrazi S, Gordon T, Lidberg M. Improving lateral performance of longer 
% combination vehicles—An approach based on eigenstructure assignment. 
% In2012 IEEE Intelligent Vehicles Symposium 2012 Jun 3 (pp. 328-333).



clear
close all
kph=1/3.6;

% load vehicle parameters and set speed
Nordic01_par
U=80*kph;

%build state-space model - see articABCD for more details
[Am,Bm,Cm,Dm]=articABCD(M,J,L,Ca,Xf,Xr,U);

%simulate step response and plot yaw velocities
sys=ss(Am,Bm(:,1),Cm,Dm(:,1)); %steering only at front axle
[y,t] = step(sys,5);
figure, plot(t,y(:,2:4))
xlabel('time (s)'),ylabel('yaw rate (rad/sec)')
legend('unit1','unit2','unit3')










