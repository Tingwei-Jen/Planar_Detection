clear;
clc;
% N = 100;
% pts(1:N,1) = rand(1,N)*5;
% pts(1:N,2) = rand(1,N)*5;
% pts(1:N,3) = rand(1,N)*0.5;
% 
% pts(N+1:2*N,1) = rand(1,N)*10+5;
% pts(N+1:2*N,2) = rand(1,N)*3;
% pts(N+1:2*N,3) = rand(1,N)*0.5;
% 
% x = pts(:,1);
% y = pts(:,2);
% z = pts(:,3);
% 
% k = convhull(pts(:,1),pts(:,2));
% k = boundary(x,y);
% 
% plot(x(k),y(k),'r-',x,y,'b*')
% 
% shp = alphaShape(x,y,50);
% plot(x,y,'b*');
% hold on;
% plot(shp);
% hold on;  
% grid on;
% axis equal;
% rotate3d on;


xx = -1:.05:1; yy = abs(sqrt(xx));
[x,y] = pol2cart(xx,yy);
k = convhull(x,y);
hold on
plot(x(k),y(k),'r-',x,y,'b+')
x_test = rand(10,1);
y_test = rand(10,1);
IN = inpolygon(x_test,y_test,x(k),y(k));
plot(x_test(IN),y_test(IN),'g*',x_test(~IN),y_test(~IN),'y*')
hold off











