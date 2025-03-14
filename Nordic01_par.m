% Nordic01_par.m
% data Sogol paper 3 unit (Nordic01)

%masses and yaw inertias
M=[23,3,34]*1000; 
J=[15,3,46]*1000;

%axle locations rel to mass centres
L1=[3.88,-1.02,-2.39];
L2=[0.65,-0.65];
L3=[-1.33,-2.64,-3.95];
L={L1,L2,L3};

%joint locations (front, rear) relative to CG
Xf=[5.88,4.45,5.47];
Xr=[-3.49,0,-5.95];

%cornering stiffnesses
Ca1=[356,480,480]*1000;
Ca2=[402,402]*1000;
Ca3=[432,432,432]*1000;
Ca={Ca1,Ca2,Ca3};







