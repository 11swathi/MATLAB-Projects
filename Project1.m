clear; 
clc; 
close all;
load('usps_all.mat')

% Q1
figure;

for i = 1:10
    subplot(2, 5, i);
    pixel_values = squeeze(data(:, 1, i));
    image_data = reshape(pixel_values, [16, 16]);
    imshow(image_data, []);
    title(['Digit ', num2str(mod(i , 10))]);
end

% Q2
figure(2);

for i = 1:10
    sample_mean = mean(data(:, :, i), 2);
    sample_mean_image = reshape(sample_mean, [16, 16]);
    subplot(2, 5, i);
    imshow(sample_mean_image, []);
    title(['Mean of Digit ', num2str(mod(i , 10))]);
end

% Q3
figure(3);
digit_mean=zeros(256,10);

for i=1:10
    digit_data=squeeze(data(:,:,i));
    digit_mean(:,i)=mean(digit_data,2);
end

overall_mean = mean(digit_mean, 2);
overall_mean_image = reshape(overall_mean, [16, 16]);


imshow(overall_mean_image, []);
title('Overall Average of all Handwritten Digits');

% Q4
figure(4);

for i = 1:10
    subplot(2, 5, i);
    digits = double(squeeze(data(:, :, i)));
    cov_matrix = cov(digits');  
    imshow(cov_matrix,[]);
    title(['Digit ', num2str(mod(i , 10))]);
end

% Q5
% Number of classes (digits)
num_classes = size(data, 3);

% Number of training points (images) per class
num_training_points = size(data, 2);

% Size of individual image (assuming square images)
image_size = size(data, 1);

% Initialize arrays to store sample means and covariance matrices
sample_means = zeros(image_size^2, num_classes);
sample_covariances = zeros(image_size^2, image_size^2, num_classes);

% Compute sample means and covariance matrices for each class
for i = 1:num_classes
    % Extract images for the current class
    class_images = squeeze(data(:, :, i));
    
    % Compute sample mean vector
    sample_means(:, i) = mean(class_images, 2);
    
    % Compute sample covariance matrix
    sample_covariances(:, :, i) = cov(class_images');
end

% Display sample means and covariance matrices
for i = 1:num_classes
    disp(['Class ', num2str(i)]);
    disp('Sample Mean:');
    disp(reshape(sample_means(:, i), image_size, image_size));
    disp('Sample Covariance Matrix:');
    disp(sample_covariances(:, :, i));
end

%Q6
% all rows, all columns, class 7
a = data(:, :, 7);
disp(['Size of the data for data(:, :, 7): ', num2str(size(a))]);

% all rows, column 5, class 7
b = data(:, 5, 7);
disp(['Size of the data for data(:, 5, 7): ', num2str(size(b))]);

% row 45, column 5, class 7
c = data(45, 5, 7);
disp(['Size of the data for data(45, 5, 7): ', num2str(size(c))]);

% row 2, all columns, all class
d = data(2, :, :);
disp(['Size of the data for data(2, :, :): ', num2str(size(d))]);

% all rows, column 6, all class
e = data(:, 6, :);
disp(['Size of the data for data(:, 6, :): ', num2str(size(e))]);

% The outputs are very large, so I printed the size of the outputs first
% Then over all outputs are printed below:
disp('Output for data(:, :, 7)');
disp(a);
disp('Output for data(:, 5, 7)');
disp(b);
disp('Output for data(45, 5, 7)');
disp(c);
disp('Output for data(2, :, :)');
disp(d);
disp('Output for data(:, 6, :)');
disp(e);

% Q7
% Get the images of digit 1
images = data(:,:,1:10);

% Get the 1st image of digit 1
image_1 = images(:,1,1);

% Get the 100th image of digit 1
image_100 = images(:,100,1);

% Distances
L1_distance = sum(abs(image_1(:) - image_100(:)));
L2_distance = sqrt(sum(abs(image_1(:) - image_100(:)).^2));
L_infinity_distance = max(abs(image_1(:) - image_100(:)));

fprintf('L1 distance: %.2f\n', L1_distance);
fprintf('L2 distance: %.4f\n', L2_distance);
fprintf('L∞ distance: %.2f\n', L_infinity_distance);