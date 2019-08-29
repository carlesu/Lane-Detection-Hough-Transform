# PerceptionSystems-ETSEIB
Practical application of image processing and recognition techniques with matlab.

## Table of contents

* [Abstract](#abstract)
* [Image capture](#image-capture)
* [Image pre-processing](#image-pre-processing)
* [Hough transform](#hough-transform)


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
<img src="/Video_Demos/img/raw_image.JPG" width="500">

##### ROI selection
<img src="/Video_Demos/img/roi_selection.JPG" width="500">

### 2. Image  smoothing (Gaussian Filter)
A Gaussian filter is done to the ROI image in order to reduce noise and smooth the edges.

Gaussian filtering averages the pixels arround each pixel of the image, the pixels averaged are determined by the kernel (matrix) size.

<img src="/Video_Demos/img/gauss_filt.jpg" width="200">

Because a Gaussian distribution is used the kernel size will be **6*Std** in order to fit the Gaussian curve to our kernel.
<img src="/Video_Demos/img/std_dev.jpg" width="200">

The noise reduction using an averaging kernel comes with image information loss, in order to benefit from smoothening without losing too much information the standard deviation will be Std = 1.

Image below shows different results for the edge detector with different Std values. On the left size the Std is too low so there is too much noise even inside the lane line. On the right side the Std is too high which makes the two lane lines fuse at some point. 

<img src="/Video_Demos/img/gauss_comparison.JPG" width="700">

### 3. Grayscale
After smoothening the image an RGB to Gray process is made using MATLAB function rgb2gray. From now on each operation made to the image will be 1024x1024x1 instead of 1024x1024x3 making the algorithm less computational demanding and also reaching good results.

The equation used for the grayscaling is (𝑦=0.299𝑅+0.5870𝐺+0.1140𝐵).

##### Gray Image
<img src="/Video_Demos/img/gray_roi.JPG" width="500">

### 4. Horizontal filtering (Marcos Nieto)
In my research phasse for this project I found several methods and ways of finding lane marks, one step that lead my algorithm to good results was a pre-processing step presented by **Marcos Nieto** in his paper __"Road environment modeling using robust perspective analysis
and recursive Bayesian segmentation"__.

This technique is based on the assumption that, in a row of image, the pixels which belong to lane markings tend to have "high intensity value surrounded by darker regions". Thus, the detector independently filters each row of image by its pixels intensity values.

<img src="/Video_Demos/img/nieto_formula.JPG" width="300">
The filter highly responds to the pixels, which have higher intensity values than their left and right neighbors in the same row at distance Tau (lane markings width). The last term of equation is removed from filtered value yi to help the filter less prone to errors, especially in the case that the difference between intensity values of left and right neighbors is too high.

##### Grayscaled ROI filtered
<img src="/Video_Demos/img/nieto_feature.JPG" width="500">

### 5. Binarization
Thresholding is used to decide which pixels we want to keep while discard the others based on their intensity values. In the image output from step 4., the pixels that belong to lane-marking evidence tend to have higher intensity values. Besides, the disturbances may leave in the image many lower intensity pixels represented as thin and weak edges. Binary thresholding can help significantly in removing these noises and enhancing the "good" pixels.

The basic idea behind binary thresholding is that all pixels that have intensity values higher than a certain threshold will be set to maximum value maxVal, while the others with intensity values below the threshold are set to zero. In this case Otsu's method will be used where the threshold is determined by minimizing intra-class intensity variance, or equivalently, by maximizing inter-class variance. At the end in order to reduce noise, conected components less than 90 px are suppressed.

##### Binarized image
<img src="/Video_Demos/img/otsu_binary.JPG" width="500">

##### Conected components suppression
<img src="/Video_Demos/img/conected_comp_90.JPG" width="500">

### 6. Edge detector
After many layers of pre-processing stage, edge detection is the final one used to find strong edges which will help the Hough transform stage to find the lane lines.

A Canny edge detector is used in this project, this method is very computational demanding because runs several steps which also make it very effective. Since our image is very well conditioned a Sobel edge detector could be used in vertical an horizontal directions in order to increase computational speed (Testing led on a 20% decrese time per frame using Sobel).

Canny edge detector makes a Gaussian filter, then applies four filters to detect horizontal, vertical and diagonal edges, which find the intensity gradients of the image. Once the intensity gradients are found performs a non-maximum suppression to get rid of spurious response to edge detection.

After application of non-maximum suppression, remaining edge pixels provide a more accurate representation of real edges in an image. However, some edge pixels remain that are caused by noise and color variation. In order to account for these spurious responses, it is essential to filter out edge pixels with a weak gradient value and preserve edge pixels with a high gradient value. This is accomplished by selecting high and low threshold values.

So far, the strong edge pixels should certainly be involved in the final edge image, as they are extracted from the true edges in the image. However, there will be some debate on the weak edge pixels, as these pixels can either be extracted from the true edge, or the noise/color variations. To achieve an accurate result, the weak edges caused by the latter reasons should be removed.

##### Canny edge detection
<img src="/Video_Demos/img/canny_edge2.JPG" width="500">

# BUILDING....

## Hough Transform
In this study Hough transform will be used in order to find the lines that best represent the lane edges. This can be a complicated task because some parameters need to be tuned in order to achieve best results.
- Bin size named 'RhoResolution', higher values for this parameters lead 

el tamaño del bin 'RhoResolution' determinará la facilidad de que los puntos sean propensos a ser interpretados como de la misma línea, 'Theta' definirá el rango de valores de θ que utilizará el algoritmo para detectar las líneas así que disminuyendo su resolución y su rango podemos disminuir el coste computacional del algoritmo y evitar ciertos ángulos que no serán de interés, 'Threshold' permite controlar cuantos votos son necesarios para considerar una línea.

### Bin Size
<img src="/Video_Demos/img/hough_bons.jpg" width="500">
<img src="/Video_Demos/img/hough_tunning.JPG" width="700">
<img src="/Video_Demos/img/hough_good.JPG" width="500">

## Classification good/bad lines
<img src="/Video_Demos/img/hough_left_slopes.JPG" width="500">
<img src="/Video_Demos/img/hough_right_slopes.JPG" width="500">
<img src="/Video_Demos/img/hough_start_end.JPG" width="500">
<img src="/Video_Demos/img/hough_good_lines1.JPG" width="500">
<img src="/Video_Demos/img/hough_good_lines2.JPG" width="500">
<img src="/Video_Demos/img/hough_voted1.JPG" width="500">

### Two more voted averaged
<img src="/Video_Demos/img/hough_average.JPG" width="500">

### Tracking vs average
<img src="/Video_Demos/img/tracking1.JPG" width="500">

## Results
<img src="/Video_Demos/img/good_bad1.JPG" width="700">
<img src="/Video_Demos/img/good_bad2.JPG" width="700">
