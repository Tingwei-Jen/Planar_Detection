%% PARAMETER
N = 20; 
outlier_threshold = 0.5;


%% Generate Data
data(:,1) = rand(1,N)*10;
data(:,2) = rand(1,N)*10;
data(:,3) = rand(1,N)*2;

plot3(data(:,1),data(:,2),data(:,3),'b*');
grid on;
axis equal;
rotate3d on;
hold on;

%% PCA
[U_reduced, Normal_Vecotr, avg] = PCA(data);

% plot normal vector 
quiver3(0, 0, 0, U_reduced(1,1), U_reduced(2,1), U_reduced(3,1), 'b');
hold on;
quiver3(0, 0, 0, U_reduced(1,2), U_reduced(2,2), U_reduced(3,2), 'r');
hold on;
quiver3(0, 0, 0, Normal_Vecotr(1,1), Normal_Vecotr(2,1), Normal_Vecotr(3,1),'g');
hold on;

%% Find plane
% normal vector (a,b,c) pass through avg(x0, y0, z0);
% Ax+By+Cz+D = 0
[x, y]=meshgrid(0:0.1:10);
A = Normal_Vecotr(1,1);
B = Normal_Vecotr(2,1);
C = Normal_Vecotr(3,1);
D = -avg*Normal_Vecotr;

z = (-A*x-B*y-D)/C;
mesh(x,y,z);

%% Find distance between points and plane
% distance of (x1,y1,z1) and plane with [A,B,C,D]
% d = abs( A*x1 + B*y1 + C*z1 +D )
D = repmat(D,N,1);
d = abs(data*Normal_Vecotr+D);

% plot outliers
for i=1:N
    
    if d(i) > outlier_threshold
    
        plot3(data(i,1),data(i,2),data(i,3),'r*')
        
    end
end










