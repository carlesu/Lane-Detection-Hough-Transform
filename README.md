# PerceptionSystems-ETSEIB
Practical application of image processing and recognition techniques with matlab.

## Table of contents

* [Abstract](#abstract)
* [Image capture](#image-capture)
* [Image pre-processing](#image-pre-processing)

## Abstract
This project presents and offline method for detecting lane lines using Hough transform.
The images are captured with my own smartphone (Xiaomi Mi A2) carried inside the vehicle fixed with a sucktion cup device. The smartphone frame rate is 30 FPS.

The first step is image conditioning in order to eliminate non interest elements, followed by an edge detector, the edge detector binary image output will be the input to the Hough transform in order to detect lines. Two best lines from each side will be chosen and averaged. Finally the averaged two lines will be tracked in a 10 frames window.

![pipeline](https://github.com/carlesu/Lane-Detection-Hough-Transform/blob/master/Video_Demos/img/raw_image.JPG)

## Image capture
Images were captured with my smartphone Xiaomi Mi A2 carried inside the vehichle and fixed to the car front glass using a sucktion cup device as shown in the picture.

## Image pre-processing
