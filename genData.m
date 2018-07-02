function pts = genData(N, a, b, c, thickness)
    %% Generate data
    pts(1:N,1) = rand(1,N)*a;
    pts(1:N,2) = rand(1,N)*b;
    pts(1:N,3) = rand(1,N)*thickness;

    pts(N+1:2*N,1) = rand(1,N)*thickness+a;
    pts(N+1:2*N,2) = rand(1,N)*b;
    pts(N+1:2*N,3) = rand(1,N)*c;

    pts(2*N+1:3*N,1) = rand(1,N)*a;
    pts(2*N+1:3*N,2) = rand(1,N)*thickness+b;
    pts(2*N+1:3*N,3) = rand(1,N)*c;
    
    Rx = [1 0 0; 0 0.707 -0.707; 0 0.707 0.707];
    Ry = [0.707 0 0.707; 0 1 0; -0.707 0 0.707];
    pts = (Rx*Ry*pts')';
end