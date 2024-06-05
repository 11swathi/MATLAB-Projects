clear;
clc;
close all;
load('usps_all.mat'); 

% Q8
% Compute distances and display histograms
for i = 1:10
    distances = zeros(1, size(data, 2)); % Initialize distance array
    sample_mean = mean(data(:, :, i), 2); % Mean vector of the class
    
    % Compute Euclidean distance from the mean for each image in the class
    for j = 1:size(data, 2)
    % Ensure both the image data and the sample mean are of type double
        distances(j) = norm(double(data(:, j, i)) - double(sample_mean));
    end

    % Calculate the mean of the distances
    meanDistance = mean(distances);
    
    % Plot histogram of distances
    figure; % Create new figure for each histogram
    histogram(distances);
    hold on;
    % Plot a vertical line representing the mean distance
    yLimits = ylim; % Get the current y-axis limits
    line([meanDistance meanDistance], yLimits, 'Color', 'red', 'LineWidth', 2);
    title(['Histogram of Euclidean Distances for Digit ', num2str(mod(i, 10))]);
    xlabel('Euclidean Distance to Mean Image');
    ylabel('Frequency');
    hold off;
end

% Q9
average_distances = zeros(1, 10); % Initialize array to store average distances for each class

% Compute distances, display histograms, and calculate average distances
for i = 1:10
    distances = zeros(1, size(data, 2)); % Initialize distance array
    sample_mean = mean(data(:, :, i), 2); % Mean vector of the class
    
    % Compute Euclidean distance from the mean for each image in the class
    for j = 1:size(data, 2)
        distances(j) = norm(double(data(:, j, i)) - double(sample_mean));
    end
    
    % Calculate the average distance for the current class
    average_distances(i) = mean(distances);
    
end

% Display the average distances
disp('Average distances from the sample mean image to the vectors in the same class:');
for i = 1:10
    fprintf('Digit %d: %f\n', mod(i, 10), average_distances(i));
end

% Q10
% Number of nearest neighbors
K = 20;

% Loop through each digit class
for i = 1:10
    % Calculate the mean image for the current class
    sample_mean = mean(data(:, :, i), 2);
    
    % Initialize matrix to store distances and their indices
    distances = zeros(100, 1); % There are 100 images to consider
    
    % Compute Euclidean distance from the mean for the first 100 images in the class
    for j = 1:100
        distances(j) = norm(double(data(:, j, i)) - double(sample_mean));
    end
    
    % Find the indices of the 20 nearest neighbors
    [~, sortedIndices] = sort(distances, 'ascend');
    nearestNeighborIndices = sortedIndices(1:K);
    
    % Display the indices of the 20 nearest neighbors
    fprintf('20 Nearest Neighbors for Digit %d: ', mod(i, 10));
    disp(nearestNeighborIndices');
end

% Q11
% Compute distances using L1 norm and display histograms
for i = 1:10
    distances = zeros(1, size(data, 2)); % Initialize distance array
    sample_mean = mean(data(:, :, i), 2); % Mean vector of the class
    
    % Compute L1 distance from the mean for each image in the class
    for j = 1:size(data, 2)
        distances(j) = sum(abs(double(data(:, j, i)) - double(sample_mean)));
    end
    
    % Calculate the mean of the distances
    meanDistance = mean(distances);

    % Plot histogram of distances
    figure; % Create new figure for each histogram
    histogram(distances);
    hold on;

    % Plot a vertical line representing the mean distance
    yLimits = ylim; % Get the current y-axis limits
    line([meanDistance meanDistance], yLimits, 'Color', 'red', 'LineWidth', 2);
    title(['Histogram of L1 Distances for Digit ', num2str(mod(i, 10))]);
    xlabel('L1 Distance to Mean Image');
    ylabel('Frequency');
    hold off;
end

% Q12
% Number of nearest neighbors
K = 20;

% Loop through each digit class
for i = 1:10
    % Calculate the mean image for the current class
    sample_mean = mean(data(:, :, i), 2);
    
    % Initialize matrix to store distances and their indices
    distances = zeros(100, 1); % There are 100 images to consider
    
    % Compute Manhattan distance (L1 norm) from the mean for the first 100 images in the class
    for j = 1:100
        distances(j) = sum(abs(double(data(:, j, i)) - double(sample_mean)));
    end
    
    % Find the indices of the 20 nearest neighbors
    [~, sortedIndices] = sort(distances, 'ascend');
    nearestNeighborIndices = sortedIndices(1:K);
    
    % Display the indices of the 20 nearest neighbors
    fprintf('20 Nearest Neighbors for Digit %d (L1 Norm): ', mod(i, 10));
    disp(nearestNeighborIndices');
end