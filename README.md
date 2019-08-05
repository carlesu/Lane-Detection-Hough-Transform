# PerceptionSystems-ETSEIB
Practical application of image processing and recognition techniques with matlab.

## Table of contents

* [Abstract](#abstract)
* [Image capture](#image-capture)
* [Image pre-processing](#image-pre-processing)

## Abstract
This project presents and offline method for detecting lane lines using Hough transform.
The images are captured with my own smartphone carried inside the vehicle. The smartphone frame rate is 30 FPS.

The first step is image conditioning in order to eliminate non interest elements, followed by an edge detector, the edge detector binary image output will be the input to the Hough transform in order to detect lines. Two best lines from each side will be chosen and averaged. Finally the averaged two lines will be tracked in a 10 frames window.
<img src="/Video_Demos/img/pipeline.JPG" width="300">

## Image capture
Images were captured with my smartphone Xiaomi Mi A2 carried inside the vehichle and fixed to the car front glass using a sucktion cup device as shown in the picture.

## Image pre-processing
### 1. Region of interest (ROI)
Since the camera will be fixed in the same spot inside the vehicle a ROI will be extracted from the raw image on each frame. In this project ROI coordinates are calibrated once and used for the whole video, a good way of finding ROI coordinates could be finding vanishing point coordinates and calculating ROI coordinates after that.

##### Raw image
<img src="/Video_Demos/img/raw_image.JPG" width="400">

##### ROI selection
<img src="/Video_Demos/img/roi_selection.JPG" width="400">

### 2. Image  smoothing (Gaussian Filter)
A Gaussian filter is done to the ROI image in order to reduce noise and smooth the edges.

Gaussian filtering averages the pixels arround each pixel of the image, the pixels averaged are determined by the kernel (matrix) size.

<img src="/Video_Demos/img/gauss_filt.jpg" width="200">

Because a Gaussian distribution is used the kernel size will be **6*Std** in order to fit the Gaussian curve to our kernel.
<img src="/Video_Demos/img/std_dev.jpg" width="200">

The noise reduction using an averaging kernel comes with image information loss, in order to benefit from smoothening without losing too much information the standard deviation will be Std = 1.

Image below shows different results for the edge detector with different Std values. On the left size the Std is too low so there is too much noise even inside the lane line. On the right side the Std is too high which makes the two lane lines fuse at some point. 

<img src="/Video_Demos/img/gauss_comparison.JPG" width="500">

### 3. Grayscale
After smoothening the image an RGB to Gray process is made using MATLAB function rgb2gray. From now on each operation made to the image will be 1024x1024x1 instead of 1024x1024x3 making the algorithm less computational demanding and also reaching good results.

The equation used for the grayscaling is (𝑦=0.299𝑅+0.5870𝐺+0.1140𝐵).

##### Gray Image
<img src="/Video_Demos/img/gray_roi.JPG" width="400">

### 4. Horizontal filtering (Marcos Nieto)
In my research phasse for this project I found several methods and ways of finding lane marks, one step that lead my algorithm to good results was a pre-processing step presented by Marcos Nieto in his paper __"Road environment modeling using robust perspective analysis
and recursive Bayesian segmentation"__.

This technique is based on the assumption that, in a row of image, the pixels which belong to lane markings tend to have "high intensity value surrounded by darker regions". Thus, the detector independently filters each row of image by its pixels intensity values.

<img src="/Video_Demos/img/nieto_formula.JPG" width="500">
The filter highly responses to the pixels, which have higher intensity values than their left and right neighbors in the same row at distance Tau. The last term of equation is removed from filtered value yi to help the filter less prone to errors, especially in the case that the difference between intensity values of left and right neighbors is too high.
