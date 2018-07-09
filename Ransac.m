function [coeff] = Ransac(pts, sampleNum, iterNum, thDist, mplot, axisrange)

%% parameter
ptNum= size(pts,1);
inlrNum = zeros(iterNum,1);
coeff1 = zeros(iterNum,4);

x_bound_up = max(pts(:,1));    y_bound_up = max(pts(:,2));    z_bound_up = max(pts(:,3));    
x_bound_down = min(pts(:,1));  y_bound_down = min(pts(:,2));  z_bound_down = min(pts(:,3));    

%% Begin ransac

for i = 1:iterNum
    
    % 1. fit plane using sampleNum random points
    sampleIdx = randi([1 ptNum],1,sampleNum);
    ptSample = pts(sampleIdx,:);
    [U_reduced, Normal_Vector, avg] = PCA(ptSample);
    [A,B,C,D] = getPlane(Normal_Vector, avg);
    
    % 2. count the inliers, if more than thInlr, refit; else iterate
    dist1 = abs(pts*Normal_Vector + repmat(D,ptNum,1));
    inlier1 = find(dist1 < thDist);
    inlrNum(i) = length(inlier1);
    coeff1(i,1) = A;
    coeff1(i,2) = B;
    coeff1(i,3) = C;
    coeff1(i,4) = D;
    
    %plot
    if mplot ==1
        w = waitforbuttonpress;  
        if w == 1
            clf;
            p0 = plot3(pts(:,1),pts(:,2),pts(:,3),'b*');
            axis([x_bound_down-0.5 x_bound_up+0.5 y_bound_down-0.5 y_bound_up+0.5 z_bound_down-0.5 z_bound_up+0.5]);
            grid on;
            axis equal;
            rotate3d on;
            hold on;
        end
        
        w = waitforbuttonpress;    
        if w == 1
            p1 = plot3(ptSample(:,1),ptSample(:,2),ptSample(:,3),'r*'); 
        end
        
        w = waitforbuttonpress;    
        if w == 1   
            p2 = quiver3(0, 0, 0, Normal_Vector(1,1)*3, Normal_Vector(2,1)*3, Normal_Vector(3,1)*3,'r');
        end
        
        w = waitforbuttonpress;    
        if w == 1   
            x = x_bound_down:0.1:x_bound_up;
            y = y_bound_down:0.1:y_bound_up;
            [X, Y]=meshgrid(x,y);
            Z = (-A*X-B*Y-D)/C;
            p3 = mesh(X,Y,Z);
            axis([x_bound_down-0.5 x_bound_up+0.5 y_bound_down-0.5 y_bound_up+0.5 z_bound_down-0.5 z_bound_up+0.5]);
        end
        
        w = waitforbuttonpress;    
        if w == 1   
            ptinliers= pts(inlier1,:);
            p4 = plot3(ptinliers(:,1),ptinliers(:,2),ptinliers(:,3),'k*');
            hold on;
        end
    end

end

% 3. choose the coef with the most inliers
[~,idx] = max(inlrNum);
coeff = coeff1(idx,:);


end 