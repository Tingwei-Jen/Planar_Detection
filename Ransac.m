function [coeff] = Ransac(pts, sampleNum, iterNum, thDist, mplot, axisrange)

%% parameter

    ptNum= size(pts,1);
    inlrNum = zeros(iterNum,1);
    coeff1 = zeros(iterNum,4);

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
            grid on;
            axis equal;
            
            %axis([-0.5 axisrange(1)+0.5 -0.5 axisrange(2)+0.5 -0.5 axisrange(3)+0.5]);
            axis([-0.5 20 -5 20 -10 15]);
            rotate3d on;
            hold on;
        end
        
        w = waitforbuttonpress;    
        if w == 1
            p1 = plot3(ptSample(:,1),ptSample(:,2),ptSample(:,3),'r*'); 
        end
        
        w = waitforbuttonpress;    
        if w == 1   
            p2 = quiver3(0, 0, 0, Normal_Vector(1,1), Normal_Vector(2,1), Normal_Vector(3,1),'r');
        end
        
        w = waitforbuttonpress;    
        if w == 1   
            [x, y]=meshgrid(0:0.1:axisrange(1));
            z = (-A*x-B*y-D)/C;
            p3 = mesh(x,y,z);
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