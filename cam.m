%{
CAM Design Assistant
SMK Production Engineering Center
Dwell - Rise - Dwell - Return CAM
2022-12-07
%}
%% Variable declaration
% All values in degree
% eventAngle = [rise start - rise end - return start- return end]
clc; close all; clear all;
eventAngle = [120 150 160 190]; %degree
h = -12; % stroke in mm
rPrime = 60; %mm
RPM = 66.6
bRise = eventAngle(2) - eventAngle(1) ; %rise period
bReturn = eventAngle(4) - eventAngle(3) ; %return period
% point in time with acceleration change
% points of events = [1-rise, 2-rise +1/8, 3-rise +7/8, 4-rise end, 5-return, 6-return +1/8, 7-return +7/8, 8-return end]
point = [eventAngle(1) eventAngle(1)+bRise/8 eventAngle(1)+7*bRise/8 eventAngle(2) eventAngle(3) eventAngle(3)+bReturn/8 eventAngle(3)+7*bReturn/8 eventAngle(4)];
step = 1;
theta = 0:step:360;
%============================================
% ACCELERATION
%============================================
aConst = 5.5279571; %constant used to calculate a
hb_2_rise = h/bRise^2;
hb_2_return = h/bReturn^2;
% Rise
temp = theta(theta<point(1));
aDwe1 = zeros(size(temp));
aRise1 = aConst*hb_2_rise*sin(4*pi.*(theta(theta >= point(1) & theta < point(2))-point(1))/bRise);
aRise2 = aConst*hb_2_rise*cos(4/3*pi.*(theta(theta >= point(2) & theta < point(3))-point(1))/bRise-pi/6);
aRise3 = aConst*hb_2_rise*sin(4*pi.*(theta(theta >= point(3) & theta <= point(4))-point(1))/bRise-2*pi);
% Dwell
temp = theta(theta > point(4) & theta < point(5));
aDwe2 = zeros(size(temp));
% Return
aReturn1 = -aConst*hb_2_return*sin(4*pi.*(theta(theta >= point(5) & theta < point(6))-point(5))/bReturn);
aReturn2 = -aConst*hb_2_return*cos(4/3*pi.*(theta(theta >= point(6) & theta < point(7))-point(5))/bReturn-pi/6);
aReturn3 = -aConst*hb_2_return*sin(4*pi.*(theta(theta >= point(7) & theta <= point(8))-point(5))/bReturn-2*pi);
% Dwell
temp = theta(theta > point(8) & theta <= 360);
aDwe3 = zeros(size(temp));
% Entire trajectory
a = [aDwe1 aRise1 aRise2 aRise3 aDwe2 aReturn1 aReturn2 aReturn3 aDwe3];
figure;
plot(theta,a);
xlim([0 360]);
grid on;
legend("加速 a");
%============================================
% VELOCITY
%============================================
vConst = 0.43990085; %constant used to calculate v
hb_rise = h/bRise;
hb_return = h/bReturn;
% Rise
temp = theta(theta<point(1));
vDwe1 = zeros(size(temp));
vRise1 = vConst*hb_rise*(1-cos(4*pi.*(theta(theta >= point(1) & theta < point(2))-point(1))/bRise));
vRise2 = vConst*hb_rise*(1+3*sin(4/3*pi.*(theta(theta >= point(2) & theta < point(3))-point(1))/bRise-pi/6));
vRise3 = vConst*hb_rise*(1-cos(4*pi.*(theta(theta >= point(3) & theta <= point(4))-point(1))/bRise-2*pi));
% Dwell
temp = theta(theta > point(4) & theta < point(5));
vDwe2 = zeros(size(temp));
% Return
vReturn1 = -vConst*hb_return*(1-cos(4*pi.*(theta(theta >= point(5) & theta < point(6))-point(5))/bReturn));
vReturn2 = -vConst*hb_return*(1+3*sin(4/3*pi.*(theta(theta >= point(6) & theta < point(7))-point(5))/bReturn-pi/6));
vReturn3 = -vConst*hb_return*(1-cos(4*pi.*(theta(theta >= point(7) & theta <= point(8))-point(5))/bReturn-2*pi));
% Dwell
temp = theta(theta > point(8) & theta <= 360);
vDwe3 = zeros(size(temp));
% Entire trajectory
v = [vDwe1 vRise1 vRise2 vRise3 vDwe2 vReturn1 vReturn2 vReturn3 vDwe3];
figure;
plot(theta,v);
xlim([0 360]);
grid on;
legend("速度 v");
%============================================
% DISPLACEMENT
%============================================
% constants used to calculate s
% Rise
temp = theta(theta<point(1));
sDwe1 = zeros(size(temp));
tempTheta = theta(theta >= point(1) & theta < point(2))-point(1);
sRise1 = h/(4+pi)*(pi*tempTheta/bRise - 1/4*sin(4*pi*tempTheta/bRise));
tempTheta = theta(theta >= point(2) & theta < point(3))-point(1);
sRise2 = h/(4+pi)*(2+pi*tempTheta/bRise-9/4*sin(pi/3+4*pi/3*tempTheta/bRise));
tempTheta = theta(theta >= point(3) & theta <= point(4))-point(1);
sRise3 = h/(4+pi)*(4+ pi*tempTheta/bRise - 1/4*sin(4*pi*tempTheta/bRise));
% Dwell
temp = theta(theta > point(4) & theta < point(5));
sDwe2 = zeros(size(temp)) + h;
% Return
tempTheta = theta(theta >= point(5) & theta < point(6))-point(5);
sReturn1 = h/(4+pi)*(4 + pi - pi*tempTheta/bReturn + 1/4*sin(4*pi*tempTheta/bReturn));
tempTheta = theta(theta >= point(6) & theta < point(7))-point(5);
sReturn2 = h/(4+pi)*(2+ pi - pi*tempTheta/bReturn  + 9/4*sin(pi/3+4*pi/3*tempTheta/bReturn));
tempTheta = theta(theta >= point(7) & theta <= point(8))-point(5);
sReturn3 = h/(4+pi)*(pi - pi*tempTheta/bReturn + 1/4*sin(4*pi*tempTheta/bReturn));
% Dwell
temp = theta(theta > point(8) & theta <= 360);
sDwe3 = zeros(size(temp));
% Entire trajectory
s = [sDwe1 sRise1 sRise2 sRise3 sDwe2 sReturn1 sReturn2 sReturn3 sDwe3] + rPrime;
figure;
plot(theta,s);
grid on;
xlim([0 360]);
ylim([0 120]);
legend("位置 s");
theta2 = deg2rad(theta);
figure;
polarplot(theta2,s)