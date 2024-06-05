# MATLAB-Projects

## Project 1


1. Download the USPS Handwritten Digits data set (usps all) from the website of
Prof. Roweis. Please produce a 2 by 5 grid of images: the 1st digit “one”, the 2nd
digit “two”, the 3rd digit “three”, ..., the 9th digit “nine” and the 10th digit “zero”
from the dataset, shaped as follows:


    (1 2 3 4 5


    6 7 8 9 0)


2. From now on, we think of the pixel values as random variables. Find the sample
mean for each set of 1100 digit examples. Please produce a 2 by 5 image grid of these
averages (reshaped as 16 x 16 images), as before. 


3. Find the sample mean for all 10 full (1100 samples) sets of handwritten digit
examples. This would be the average handwritten digit from our entire collection.
Reshape it as 16 x 16 and plot this overall average image.


4. Find the sample covariance matrices for each of the 10 sets of 1100 digit exam-
ples. Please print these (256 x 256) covariance matrices on the 2 by 5 image grid as
before.


5. Now that you have calculated sample means and sample covariance matrices
define formally what would be the multivariate normal distribution modeling each
single integer class. Estimate the computational cost of computing these distributions
in practice in terms of the parameters associated with the USPS data set (such as
number of classes, number of training points, size of an individual image, or its bit
representation).


6. Consider the USPS data set of 10 classes, each consisting of 1100 examples of
16x16 images of handwritten digits, which is formed as a 256 x 1100 x 10 datacube.
Let the name of the data set be data. Answer the following questions:
- a) What does data(:, :, 7) represent?
- b) What does data(:, 5, 7) represent?
- c) What does data(45, 5, 7) represent?
- d) What does data(2, :, :) represent?
- e) What does data(:, 6, :) represent?



7. Compute the ‖‖1, ‖‖2, ‖‖∞ distances between the 1st image of 1 and the 100th
image of 1 in the USPS data set.


## Project 2
8. For the sample mean images from Q3, compute the ‖ · ‖2 distance
from the mean to each of the 1100 vector images in the corresponding class. Represent
these distances graphically, separately for each class, using for example Matlab’s
histogram function.


9. For each digit class, compute the average distance from the sample mean image
to the vectors in the same class. Does the average deviate significantly from the
distances in problem 1? If so why would that be? Give some intuitive explanation.



10. For each of the 10 mean digit images, find its 20 nearest neighbors from among
the first 100 images in the corresponding class (first 100 as ordered by the database).


11. Repeat problem 8 for the distance computed with the metric defined by ‖ · ‖1.

   
12. Repeat problem 10 for the metric defined by ‖ · ‖1. Compare the new neighbor-
hoods to those in problem 3. Do they change? If so by how much. What could cause
the change?

## Project 3


## Project 4
Use the DR Toolbox to generate a helix dataset with 2000 and 20000 points re-
spectively. Compute 2-dimensional representations of this dataset by means of kPCA
and Laplacian Eigenmaps. Measure time and deduce the order of computational
complexity of both algorithms.
Describe the changes when size of data increases, as well as the impact of the size
of data on the cost computations.
