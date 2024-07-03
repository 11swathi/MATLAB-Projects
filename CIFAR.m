clear;
clc;
close all;

% Load CIFAR-10 dataset 
load('cifar_10_shuffle.mat'); 

% Preprocess the data: normalization
all_data = double(all_data) / 255;

% Select a subset of CIFAR-10 data (first 20,000 samples)
subset_size = 20000;
data_subset = all_data(1:subset_size, :);

% Define the desired dimensionality for reduction
num_dims = 2;

% Compute LLE Embedding
tic;
lle_embedding = compute_mapping(data_subset, 'LLE', num_dims,10);
lle_time = toc;

% Plot the 2D Embeddings
figure;
subplot(1, 2, 1);
scatter(lle_embedding(:, 1), lle_embedding(:, 2), 10, all_labels(1:subset_size), 'filled');
title('LLE Embedding');
colorbar;

% Display computation times
fprintf('Time taken for LLE: %.2f seconds\n', lle_time);
% Compute ISOMAP Embedding
tic;
isomap_embedding = compute_mapping(data_subset, 'LLE',num_dims,12 );
isomap_time = toc;

subplot(1, 2, 2);
scatter(isomap_embedding(:, 1), isomap_embedding(:, 2), 10, all_labels(1:subset_size), 'filled');
title('ISOMAP Embedding');
colorbar;

fprintf('Time taken for ISOMAP: %.2f seconds\n', isomap_time);

%% Split data into train, validate, and test sets
rng(1); % Set random seed for reproducibility
train_ratio = 0.7;
validate_ratio = 0.1;
test_ratio = 0.2;

num_samples = size(data_subset, 1);
num_train = round(train_ratio * num_samples);
num_validate = round(validate_ratio * num_samples);
num_test = num_samples - num_train - num_validate;

% Shuffle indices
indices = randperm(num_samples);

% Training set
train_indices = indices(1:num_train);
train_data = data_subset(train_indices, :);
train_labels = labels_subset(train_indices);

% Validation set
validate_indices = indices(num_train + 1:num_train + num_validate);
validate_data = data_subset(validate_indices, :);
validate_labels = labels_subset(validate_indices);

% Test set
test_indices = indices(num_train + num_validate + 1:end);
test_data = data_subset(test_indices, :);
test_labels = labels_subset(test_indices);

% Train kNN classifier on each reduced-dimensional representation
num_neighbors = 20; % Number of neighbors for kNN

% Isomap
fprintf('Training kNN classifier on Isomap...\n');
kNN_Iso = fitcknn(mappedIso(train_indices, :), train_labels, 'NumNeighbors', num_neighbors);

% LLE
fprintf('Training kNN classifier on LLE...\n');
kNN_LLE = fitcknn(mappedLLE(train_indices, :), train_labels, 'NumNeighbors', num_neighbors);

% Laplacian Eigenmaps (LE)
fprintf('Training kNN classifier on Laplacian Eigenmaps...\n');
kNN_LE = fitcknn(mappedLE(train_indices, :), train_labels, 'NumNeighbors', num_neighbors);

% Diffusion Maps
fprintf('Training kNN classifier on Diffusion Maps...\n');
kNN_Diffusion = fitcknn(mappedDiffusion(train_indices, :), train_labels, 'NumNeighbors', num_neighbors);

%% Validate kNN classifiers on validation set and compute performance metrics

% Isomap
predicted_labels_Iso = predict(kNN_Iso, mappedIso(validate_indices, :));
accuracy_Iso = sum(predicted_labels_Iso == validate_labels) / numel(validate_labels);
f1_score_Iso = 2 * (sum(predicted_labels_Iso == validate_labels & validate_labels == 1) / sum(predicted_labels_Iso == 1) + ...
                   sum(predicted_labels_Iso == validate_labels & validate_labels == 0) / sum(predicted_labels_Iso == 0));
fprintf('Isomap: Accuracy=%.4f, F1-score=%.4f\n', accuracy_Iso, f1_score_Iso);

% LLE
predicted_labels_LLE = predict(kNN_LLE, mappedLLE(validate_indices, :));
accuracy_LLE = sum(predicted_labels_LLE == validate_labels) / numel(validate_labels);
f1_score_LLE = 2 * (sum(predicted_labels_LLE == validate_labels & validate_labels == 1) / sum(predicted_labels_LLE == 1) + ...
                   sum(predicted_labels_LLE == validate_labels & validate_labels == 0) / sum(predicted_labels_LLE == 0));
fprintf('LLE: Accuracy=%.4f, F1-score=%.4f\n', accuracy_LLE, f1_score_LLE);

% Laplacian Eigenmaps (LE)
predicted_labels_LE = predict(kNN_LE, mappedLE(validate_indices, :));
accuracy_LE = sum(predicted_labels_LE == validate_labels) / numel(validate_labels);
f1_score_LE = 2 * (sum(predicted_labels_LE == validate_labels & validate_labels == 1) / sum(predicted_labels_LE == 1) + ...
                   sum(predicted_labels_LE == validate_labels & validate_labels == 0) / sum(predicted_labels_LE == 0));
fprintf('Laplacian Eigenmaps: Accuracy=%.4f, F1-score=%.4f\n', accuracy_LE, f1_score_LE);

% Diffusion Maps
predicted_labels_Diffusion = predict(kNN_Diffusion, mappedDiffusion(validate_indices, :));
accuracy_Diffusion = sum(predicted_labels_Diffusion == validate_labels) / numel(validate_labels);
f1_score_Diffusion = 2 * (sum(predicted_labels_Diffusion == validate_labels & validate_labels == 1) / sum(predicted_labels_Diffusion == 1) + ...
                   sum(predicted_labels_Diffusion == validate_labels & validate_labels == 0) / sum(predicted_labels_Diffusion == 0));
fprintf('Diffusion Maps: Accuracy=%.4f, F1-score=%.4f\n', accuracy_Diffusion, f1_score_Diffusion);
