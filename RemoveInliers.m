function [pts, pts_removed] = RemoveInliers(pts, coeff, thDist)

    ptNum= size(pts,1);
    Normal_Vector = coeff(1:3)';
    D = coeff(4);
    dist1 = abs(pts*Normal_Vector + repmat(D,ptNum,1));
    inlier1 = find(dist1 < thDist);
    pts_removed = pts([inlier1],:);
    pts([inlier1],:) = [];
    
end 