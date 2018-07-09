function [T_world_plane, vertex_world, vertex_plane] = Rectangle_Removedinliers(pts_removed)

%%  Return Transformation matrix and 4 vertexs of rectangle
T_world_plane = zeros(4,4);
vertex_plane = zeros(4,4);

%% PCA
[U_reduced, Normal_Vector, avg] = PCA(pts_removed);

%%  Transformation Matrix
T_world_plane(:,1) = [U_reduced(:,1); 0];
T_world_plane(:,2) = [U_reduced(:,2); 0];
T_world_plane(:,3) = [Normal_Vector(:,1); 0];
T_world_plane(:,4) = [avg(1,:)'; 1];

%%  get plane x-y vertex
T_plane_world = inv(T_world_plane);
pts_removed_extend = [pts_removed ones(size(pts_removed,1),1)];
pts_removed_plane = (T_plane_world*pts_removed_extend')';

x_min = min(pts_removed_plane(:,1)); 
x_max = max(pts_removed_plane(:,1)); 
y_min = min(pts_removed_plane(:,2)); 
y_max = max(pts_removed_plane(:,2)); 

vertex_plane(1,1) = x_min; vertex_plane(1,2) = x_max; vertex_plane(1,3) = x_max; vertex_plane(1,4) = x_min;
vertex_plane(2,1) = y_min; vertex_plane(2,2) = y_min; vertex_plane(2,3) = y_max; vertex_plane(2,4) = y_max;
vertex_plane(3,1) = 0;     vertex_plane(3,2) = 0;     vertex_plane(3,3) = 0;     vertex_plane(3,4) = 0;
vertex_plane(4,1) = 1;     vertex_plane(4,2) = 1;     vertex_plane(4,3) = 1;     vertex_plane(4,4) = 1;

%%  get vertex world
vertex_world = T_world_plane*vertex_plane;
vertex_world = vertex_world';
vertex_plane = vertex_plane';

end 