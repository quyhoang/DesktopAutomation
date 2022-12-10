
cirDraw([4,5],1)

function cirDraw(center,R)
% Draw a circle. 
% Eg. cirDraw([4,5],1) draws a circle of radius 1 centered at (4,5)

t = linspace(0,2*pi,100);
xC = R*cos(t) + center(1);
yC = R*sin(t) + center(2);
plot(xC,yC)
end