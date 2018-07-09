clear;
clc;
clf;
%% Generate data
N = 200;
a = 20;
b = 10;
c = 5;
thickness = 2.0;
pts = genData(N, a, b, c, thickness);
pts_origin = pts;
%% Ransac 
sampleNum = 5;
iterNum = 50;
thDist = 0.8;

mplot = 0;
coeff = Ransac(pts, sampleNum, iterNum, thDist, mplot);

% remove inliers
[pts, pts_removed] = RemoveInliers(pts, coeff, thDist);

% removed inliers--> rectangle
[T_world_plane, vertex_world, vertex_plane] = Rectangle_Removedinliers(pts_removed);

% removed inliers--> convex hull
pts_CH = CH_RemovedInliers(pts_removed);


%% plot final result
plot3(pts_origin(:,1),pts_origin(:,2),pts_origin(:,3),'b.');
hold on;
plot3([vertex_world(:,1); vertex_world(1,1)],[vertex_world(:,2); vertex_world(1,2)],[vertex_world(:,3); vertex_world(1,3)],'r-');
hold on;
plot3([vertex_plane(:,1); vertex_plane(1,1)],[vertex_plane(:,2); vertex_plane(1,2)],[vertex_plane(:,3); vertex_plane(1,3)],'c-');
hold on;
plot3(pts_CH(:,1),pts_CH(:,2),pts_CH(:,3),'k');
hold on;  

grid on;
axis equal;
rotate3d on;

% origin coordinate
quiver3(0,0,0,5,0,0,'b');
quiver3(0,0,0,0,5,0,'r');
quiver3(0,0,0,0,0,5,'g');
% plane coordinate
quiver3(T_world_plane(1,4), T_world_plane(2,4), T_world_plane(3,4), T_world_plane(1,1)*3, T_world_plane(2,1)*3, T_world_plane(3,1)*3, 'b');
quiver3(T_world_plane(1,4), T_world_plane(2,4), T_world_plane(3,4), T_world_plane(1,2)*3, T_world_plane(2,2)*3, T_world_plane(3,2)*3, 'r');
quiver3(T_world_plane(1,4), T_world_plane(2,4), T_world_plane(3,4), T_world_plane(1,3)*3, T_world_plane(2,3)*3, T_world_plane(3,3)*3, 'g');
hold on;
