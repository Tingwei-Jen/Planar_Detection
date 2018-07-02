function pts_CH = CH_RemovedInliers(pts_removed)

    [U_reduced, Normal_Vector, avg] = PCA(pts_removed);
    [A,B,C,D] = getPlane(Normal_Vector, avg);
    
    pts_reduced = (U_reduced'*pts_removed')';
    k = convhull(pts_reduced(:,1),pts_reduced(:,2));
   
    pts_proj = Projection_PtstoPlane(pts_removed, A, B, C, D);
   
    pts_CH = [pts_proj(k,1) pts_proj(k,2) pts_proj(k,3)];
 
end