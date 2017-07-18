# Computer Vision Course

This project contains the source code of five different assignments done for a computer vision course:

1. Merge and alignment of three different images, each corresponding to a different color chanel (R, G, B).
2. K-means clustering applied to images.
3. Implementation of a scale-invariant blob detector, based on the Laplacian blob detector.
4. Image stitching using SIFT features.
5. Scene recognition using a bag of visual words and SIFT features.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* MATLAB along with the Statistics and Machine Learning Toolbox

### Usage

1. Get a copy of the source code of this repository by cloning it using Git or simply by downloading it.
2. To test an assignment, run the code of the file that starts with *test* located at the corresponding *Source* folder.
3. The tests take as input the images located at the *Resources* folder. Check the results, by looking into the *Output* folder. Note that in some cases, the results may differ between runs (e.g. K-means clustering results).

### Results

#### Assignment 1 - Merge and allignment of channels

Example input (three misaligned images representing the red, green and blue channels):

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%201/Resources/01112v_R.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%201/Resources/01112v_R.jpg" align="left" width="256"></a>

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%201/Resources/01112v_G.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%201/Resources/01112v_G.jpg" align="left" width="256"></a>

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%201/Resources/01112v_B.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%201/Resources/01112v_B.jpg" width="256"></a>

Example output (allignment and merge of the three channels):

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%201/Output/01112v_RGB.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%201/Output/01112v_RGB.jpg" width="256"></a>

#### Assignment 2 - K-means clustering

Example input:

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%202/Resources/mm.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%202/Resources/mm.jpg" width="512"></a>

Example output (k=3, 5 dimensions (r, g, b + x, y):

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%202/Output/Ex2/k4d5_mm.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%202/Output/Ex2/k4d5_mm.jpg" width="512"></a>

#### Assignment 3 -Laplacian blob detector

Example input:

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%203/Resources/butterfly.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%203/Resources/butterfly.jpg" width="512"></a>

Example output:

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%203/Output/output-1-cut.png"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%203/Output/output-1-cut.png" width="512"></a>

#### Assignment 4 -Laplacian blob detector

Example input:

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview1.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview1.jpg" align="left" width="128"></a>

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview2.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview2.jpg" align="left" width="128"></a>

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview3.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview3.jpg" align="left" width="128"></a>

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview4.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview4.jpg" align="left" width="128"></a>

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview5.jpg"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Resources/officeview5.jpg" width="128"></a>

Example output:

<a href="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Output/output-2.png"><img src="https://raw.githubusercontent.com/JPMMaia/computer-vision-1/master/Assignment%204/Output/output-2.png" width="512"></a>

#### Assignment 5 - Scene recognition

Training set: All images contained on the [Resources/train folder](https://github.com/JPMMaia/computer-vision-1/tree/master/Assignment%205/Resources/train).

Test set: All images contained on the [Resources/test folder](https://github.com/JPMMaia/computer-vision-1/tree/master/Assignment%205/Resources/test).

Results: The system was able to classify 60% of the test images correctly.

## Built With

* [MATLAB](https://www.mathworks.com) 
* [VLFeat](http://www.vlfeat.org/) - Open-source computer vision library

## Authors

* **Dagcan Mermi** - [siobnt](https://github.com/siobnt)
* **João Maia** - [JPMMaia](https://github.com/JPMMaia)
* **João Neto** - [JoaoFranciscoNeto](https://github.com/JoaoFranciscoNeto)
