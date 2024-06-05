clear; 
clc; 
close all;
load('usps_all.mat')

figure;

for i = 1:10
    subplot(2, 5, i);
    pixel_values = squeeze(data(:, 1, i));
    image_data = reshape(pixel_values, [16, 16]);
    imshow(image_data, []);
    title(['Digit ', num2str(mod(i , 10))]);
end

figure(2);

for i = 1:10
    sample_mean = mean(data(:, :, i), 2);
    sample_mean_image = reshape(sample_mean, [16, 16]);
    subplot(2, 5, i);
    imshow(sample_mean_image, []);
    title(['Mean of Digit ', num2str(mod(i , 10))]);
end

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

figure(4);

for i = 1:10
    subplot(2, 5, i);
    digits = double(squeeze(data(:, :, i)));
    cov_matrix = cov(digits');  
    imshow(cov_matrix,[]);
    title(['Digit ', num2str(mod(i , 10))]);
end

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