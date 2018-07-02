function [U_reduced, Normal_Vector, avg] = PCA(data)

% U_reduced: eigenvector reduce to 2 dimension
% Normal_Vecotr: normal vector of the plane
% avg: nomal vector pass through


% normalized
[N, dim] = size(data);
avg = mean(data);
data_normalized = data - repmat(avg, N, 1);

% covariance matrix
sigma = data_normalized' * data_normalized / N;
% % singular value decomposition (SVD)
[U,S,V]=svd(sigma);

% U reduced
U_reduced = U(:, 1:2);
Normal_Vector = cross(U_reduced(:,1),U_reduced(:,2));

end