function pts = genData(N, a, b, c, thickness)
    %% Generate data
    pts(1:N,1) = rand(1,N)*a+5;
    pts(1:N,2) = rand(1,N)*b+5;
    pts(1:N,3) = rand(1,N)*thickness+5;

    pts(N+1:2*N,1) = rand(1,N)*thickness+a+5;
    pts(N+1:2*N,2) = rand(1,N)*b+5;
    pts(N+1:2*N,3) = rand(1,N)*c+5;

    pts(2*N+1:3*N,1) = rand(1,N)*a+5;
    pts(2*N+1:3*N,2) = rand(1,N)*thickness+b+5;
    pts(2*N+1:3*N,3) = rand(1,N)*c+5;
    
    Rx = [1 0 0; 0 0.707 -0.707; 0 0.707 0.707];
    Ry = [0.707 0 0.707; 0 1 0; -0.707 0 0.707];
    pts = (Rx*Ry*pts')';
end