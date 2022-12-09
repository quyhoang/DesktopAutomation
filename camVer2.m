%{
CAM Design Assistant
Dwell - Rise - Dwell - Return CAM
2022-12-07
%}

% Variable declaration
% All values in degree
% eventAngle = [rise start - rise end - return start- return end]

clc; close all; clear;


%============================================
% INPUT 入力
%============================================

eventAngle = [30 70 190 230]; % degree at which the rise/return starts/ends
rRoller = 60; % roller radius in mm
h = 15; % stroke in mm
rBase = 50; % mm - Cam base radius
RPM = 200; % motor velocity in rounds per minutes

sampleRate = 5; % showing roller on pitch curve with distance in degree

%　END　OF　INPUT　=====================================

rPrime = rBase + rRoller; %mm - Pitch circle prime radius

bRise = eventAngle(2) - eventAngle(1) ; %rise period
bReturn = eventAngle(4) - eventAngle(3) ; %return period
% point in time with acceleration change
% points of events = [1-rise, 2-rise +1/8, 3-rise +7/8, 4-rise end, 5-return, 6-return +1/8, 7-return +7/8, 8-return end]
point = [eventAngle(1) eventAngle(1)+bRise/8 eventAngle(1)+7*bRise/8 eventAngle(2) eventAngle(3) eventAngle(3)+bReturn/8 eventAngle(3)+7*bReturn/8 eventAngle(4)];
step = 1;

theta = 0:step:360;
T = 60/RPM; % period of moving 360 degree, in second
time = linspace(0,T,length(theta));
timeStep = T/size(time,2); % convert step in degree to step in time

%============================================
% DISPLACEMENT
%============================================

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

% plot(theta,s);
% grid on;
% xlim([0 360]);
% xlabel({'角度','degree'},'FontSize',15,'FontWeight','light','Color','b');


plot(time,s);
grid on;
xlim([0 T]);
xlabel({'t','秒'},'FontSize',15,'FontWeight','light','Color','b');
ylim([rPrime-2*abs(h) rPrime+2*abs(h)]);
ylabel({'位置','mm'},'FontSize',15,'FontWeight','light','Color','b');
legend("位置 s");
[tit,] = title({'';'位置　vs　時間'},{['モーター回転速度 ',num2str(RPM),'rpm   ','T = ', num2str(T),'s'];''},...
    'Color','blue');
tit.FontSize = 15;

%title({'';'位置　vs　時間';['モーターの回転速度',num2str(RPM),'rpm   ','T = ', num2str(T),'s'];''},'Color','b','FontSize',15,'FontWeight','light');

theta2 = deg2rad(theta);
figure;
polarplot(theta2,s)
title({'';'位置　vs　角度';''},'Color','b','FontSize',15,'FontWeight','light');


%============================================
% VELOCITY
%============================================
% velocity with respect to time
vv = diff(s)/timeStep;
vv = [vv vv(length(vv))]; %add the last element to make the length of vv and theta equal
figure;

plot(time,vv);
grid on;
xlim([0 T]);
xlabel({'t','秒'},'FontSize',15,'FontWeight','light','Color','b');
ylabel({'速度','mm/s'},'FontSize',15,'FontWeight','light','Color','b');
%title({'';'速度　vs　時間';''},'Color','b','FontSize',15,'FontWeight','light');
[tit,] = title({'';'速度　vs　時間'},{['モーター回転速度 ',num2str(RPM),'rpm   ','T = ', num2str(T),'s'];''},...
    'Color','blue');
tit.FontSize = 15;

%============================================
% ACCELERATION
%============================================
% acceleration with respect to time
aa = diff(vv)/timeStep;
aa = [aa 0];
figure;

plot(time,aa);
grid on;
xlim([0 T]);
xlabel({'t','秒'},'FontSize',15,'FontWeight','light','Color','b');
ylabel({'加速','mm/s^2'},'FontSize',15,'FontWeight','light','Color','b');
%title({'';'加速　vs　時間';''},'Color','b','FontSize',15,'FontWeight','light');
[tit,subtit] = title({'';'加速　vs　時間'},{['モーター回転速度 ',num2str(RPM),'rpm   ','T = ', num2str(T),'s'];''},...
    'Color','blue');
tit.FontSize = 15;

%============================================
% PRESSURE ANGLE 圧角
%============================================
% tan a = {ds/d(theta)}/(s + rb + rr) %theta in degree

radianStep = deg2rad(step);
v_theta = diff(s)/radianStep; %differentiate s with respect to theta in radian
v_theta = [v_theta v_theta(length(v_theta))]; %add one more element to make the lengh equal to that of theta 
pitch_radius = s + rRoller;
tanPressureAngle = v_theta./pitch_radius;

pressureAngle = rad2deg(atan(tanPressureAngle));

figure;

plot(theta, pressureAngle);
grid on;
xlim([0 360]);
xlabel({'角度','degree'},'FontSize',15,'FontWeight','light','Color','b');
ylabel({'圧角','degree'},'FontSize',15,'FontWeight','light','Color','b');

title({'';'圧角　vs　角度';''},'Color','b','FontSize',15,'FontWeight','light');

%============================================
% RADIUS OF CURVATURE 曲率半径
%============================================
% p = {[(rb + s)^2 + (ds/dtheta)^2]^(3/2)}/[(rb + s)^2 + 2*(ds/dtheta)^2 - (rb+s)*d^2s/dtheta^2]

%second order differentiation of s with respect to theta

% Converting Polar to Cartesian Coordinate System
[x,y] = pol2cart(theta2,s);

% Draw roller around cam curve and on pitch curve 
% sample rate is defined in input region
sampleRate = round(sampleRate*length(theta2)/360);
x_sample = x_cord(1:sampleRate:length(x_cord));
y_sample = y_cord(1:sampleRate:length(y_cord));

centers = [x_sample y_sample];
radii = rRoller*ones(length(y_sample),1);
figure;
viscircles(centers,radii,'LineWidth',1);
axis equal;
grid on;
hold on;
plot(x,y);

% Plot cam profile
camSurfX = zeros(size(x));
camSurfY = zeros(size(x));

[camSurfX(1),camSurfY(1)] = normalp([x(length(x)) x(1) x(2)],[y(length(y)) y(1) y(2)],rRoller);
[camSurfX(length(x)),camSurfY(length(y))] = normalp([x(length(x)-1) x(length(x)) x(1)],[y(length(y)-1) y(length(y)) y(1)],rRoller);

for k = 1:1:length(x)-2
X = x(k:1:k+2);
Y = y(k:1:k+2);
[camSurfX(k+1),camSurfY(k+1)] = normalp(X,Y,rRoller);
end
hold on;
plot(camSurfX,camSurfY,'color','g')

% Export Cam Profile to Excel as XYZ Coordinates
% x_cord = transpose(camSurfX);
% y_cord = transpose(camSurfY);
% z_cord = zeros(length(theta2),1);
% 
% cam_profile = [x_cord y_cord z_cord];

% writematrix(cam_profile,'cam_profile.xlsx');
% writematrix(cam_profile,'cam_profile.txt');

function [xo,yo] = normalp(x,y,R)
% x and y are row vector of length 3 (longer vectors don't cause problem,
% but only the first 3 elements will be used. 

% Call the three point represented by x and y A, B and C
% This function return the coordinates of point D such that
% * DB is perpendicular to AC
% * DB has length R
% * D is on the left hand side when moving on the curve ABC from A to C

% calculate normal vector <a,b>
a = y(1)-y(3);
b = x(3)-x(1);
k = R/sqrt(a^2+b^2); 
% temporary factor
xo = k*a + x(2);
yo = k*b + y(2);
end


function [radius,radArg] = radCurv(f,arg)

% Numerically computing radius of curvature
% arg is used only to define step. In this program arg is array of angles
    step = arg(2)-arg(1);
    f1 = diff(f)/step;
    f2 = diff(f1)/step;
    f1 = regulate(f1,f2);
    ff = regulate(f,f2);
    radArg = regulate(arg,f2);
    
    k1 = 2*sqrVec(f1) + sqrVec(ff) - ff.*f2;
    k2 = (sqrVec(f1) + sqrVec(ff)).^(3/2);
    radius = k2./k1;
end

function sqrVec = sqrVec(x)
    sqrVec = x.*x;
end

function regulated = regulate(x,ref)
    regulated = x(1:length(ref));
end


% figure;
% plot(x,y);
% hold on;
% p = viscircles([x_sample(1),y_sample(1)],8,'LineWidth',1);
% hold off;
% axis equal;
% grid on;
% 
% for k = 2:1:length(x_sample)
%     p = viscircles([x_sample(k),y_sample(k)],8,'LineWidth',1);
%     drawnow
% end
