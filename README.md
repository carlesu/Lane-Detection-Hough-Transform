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

Raw image

<img src="/Video_Demos/img/raw_image.JPG" width="300">

ROI selection
<img src="/Video_Demos/img/roi_selection.JPG" width="300">
