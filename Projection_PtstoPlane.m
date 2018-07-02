function  pts_proj = Projection_PtstoPlane(pts, A, B, C, D)

    % (x,y,z) = (xp, yp, zp) + t(a,b,c)
    % ax+by+cz+d = 0
    ptNum = size(pts,1);
    Normal_Vector = [A;B;C];
    T = -(pts*Normal_Vector + repmat(D,ptNum,1))/(A*A+B*B+C*C);
    pts_proj = pts + T*Normal_Vector';

end