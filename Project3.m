clear;
clc;
close all;
tic;
[X, labels] = generate_data('helix', 2000);
	figure, scatter3(X(:,1), X(:,2), X(:,3), 5, labels); title('Original dataset for 2000 points'), drawnow
	no_dims = round(intrinsic_dim(X, 'MLE'));
	disp(['MLE estimate of intrinsic dimensionality: ' num2str(no_dims)]);
	[mappedX, ~] = compute_mapping(X, 'KernelPCA', no_dims);	
	figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels); title('Result of kPCA for 2000 points ');
    [mappedX, mapping] = compute_mapping(X, 'Laplacian', no_dims, 7);	
	figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels(mapping.conn_comp)); title('Result of Laplacian Eigenmaps for 2000 points'); drawnow
toc;

tic;
[X, labels] = generate_data('helix', 20000);
	figure, scatter3(X(:,1), X(:,2), X(:,3), 5, labels); title('Original dataset for 20,000 points'), drawnow
	no_dims = round(intrinsic_dim(X, 'MLE'));
	disp(['MLE estimate of intrinsic dimensionality: ' num2str(no_dims)]);
	[mappedX, ~] = compute_mapping(X, 'KernelPCA', no_dims);	
	figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels); title('Result of kPCA for 20,000 points');
    [mappedX, mapping] = compute_mapping(X, 'Laplacian', no_dims, 7);	
	figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels(mapping.conn_comp)); title('Result of Laplacian Eigenmaps for 20,000 points'); drawnow
toc;