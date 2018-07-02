clear;
clc;
clf;
%% Generate data
N = 200;
a = 20;
b = 10;
c = 5;
thickness = 0.5;
pts = genData(N, a, b, c, thickness);
pts_origin = pts;
%% parameter
sampleNum = 5;
iterNum = 50;
thDist = 0.6;
mplot = 0;
axisrange = [a,b,c];

lowerlimit = 50;

coeffs = zeros(3,4);

index = 1;
%% Begin
%while size(pts,1)>lowerlimit
    
    % ransac
    [coeff] = Ransac(pts, sampleNum, iterNum, thDist, mplot, axisrange);
    coeffs(index,:) = coeff;
    index = index+1;
    
    % remove inliers
    [pts, pts_removed] = RemoveInliers(pts, coeff, thDist);

    % handle removed inliers
    pts_CH = CH_RemovedInliers(pts_removed);
    plot3(pts_CH(:,1),pts_CH(:,2),pts_CH(:,3),'r-');
    hold on;  
    grid on;
    axis equal;
    rotate3d on;
    
%end

%% plot final result


plot3(pts_origin(:,1),pts_origin(:,2),pts_origin(:,3),'b*');
hold on;


% w = waitforbuttonpress;  
% if w == 1
%     for i = 1:3
% 
%         [x, y]=meshgrid(0:0.1:20);
%         A = coeffs(i,1);
%         B = coeffs(i,2);
%         C = coeffs(i,3);
%         D = coeffs(i,4);
%         z = (-A*x-B*y-D)/C;
%         p3 = mesh(x,y,z);
%         axis([-0.5 20 -5 20 -10 15]);
% 
%     end
% end



