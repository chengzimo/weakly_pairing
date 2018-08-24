# BLS-C-CCA : 
BLS-C-CCA is a weakly paired multi-modal fusion algorithm based on broad learning system

### Main idea : 
By introducing a new network broad learning system (BLS), we can extract the abstract nonlinear feature representations. At the same time, it is easy to fuse multiple modalities information matching with pairing method cluster-CCA. The weakly paired multi-modal fusion BLS framework, which named BLS-C-CCA, mainly contains two components: 
1. nonlinear feature representations of each modality learned by BLS modal separately 
2. multi-modal data fusion with a pairing algorithm cluster-CCA. 

Because that RGB and Depth images are not in correspondence with each other at all, we need to divide the training data into some groups in accordance with the sort of image and object for the pairing process.
1) Classes based on the same image  -->
For 885 images, we split all the grasping rectangles of the same image as a group. There are 885 groups in where the Depth images are randomly disturbed which results in weakly paired relationships with RGB images.
2) Classes based on the same object -->
With the different views, we employ all the images of the same object as a group. There are 240 groups and we disturb the sequence of Depth modality in each group, that is similar to the manner of image classification mentioned above.

### Dataset download :
1. We used the Cornell Grasping dataset (Grasp) --> file 'featRGBD.mat', or you can get more useful data from [here](http://pr.cs.cornell.edu/grasping/rect_data/data.php)
2. The file named 'g.mat' means the different pairing manners of data series (on a same image or a same object)
