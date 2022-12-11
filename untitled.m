
close all;

prompt = "Show machining process? Y/N [Y]: ";
txt = input(prompt,"s");

h = 15; % stroke in mm
B_deg = 40;
B = deg2rad(B_deg);
maxPressureAngle_deg = 30;
maxPressureAngle = deg2rad(maxPressureAngle_deg);

list_rRoller = linspace(1,100,200); % roller radius in mm
primeRadius = Cv*h/B/tan(maxPressureAngle)-h/2;
list_rBase = primeRadius - list_rRoller;
list_rBase = list_rBase .* (list_rBase>0);

plot(list_rRoller,list_rBase)
grid on
grid minor

% maxTan1 = Cv*h/B;
% maxTan2 = h/2 + rBase + rRoller;
% maxTan = maxTan1/maxTan2;
% maxAlpha = rad2deg(atan(maxTan))