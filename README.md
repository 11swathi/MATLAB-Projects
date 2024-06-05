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


4. Find the sample mean for all 10 full (1100 samples) sets of handwritten digit
examples. This would be the average handwritten digit from our entire collection.
Reshape it as 16 x 16 and plot this overall average image.


5. Find the sample covariance matrices for each of the 10 sets of 1100 digit exam-
ples. Please print these (256 x 256) covariance matrices on the 2 by 5 image grid as
before.


6. Now that you have calculated sample means and sample covariance matrices
define formally what would be the multivariate normal distribution modeling each
single integer class. Estimate the computational cost of computing these distributions
in practice in terms of the parameters associated with the USPS data set (such as
number of classes, number of training points, size of an individual image, or its bit
representation). 
