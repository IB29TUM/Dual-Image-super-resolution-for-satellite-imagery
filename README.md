# GANs for Super-Resolution: 

## Introduction
NN.ipynb is a Python-based implementation utilizing Generative Adversarial Networks (GANs) for enhancing the resolution of images, particularly focusing on satellite imagery trained with planet/Airbus and sentinel scenes. It combines Convolutional Neural Networks (CNNs), for both the generator and discriminator components, alongside VGG19 for deep feature extraction.

## Features
- **Residual Learning**: Incorporates residual blocks in the generator to effectively learn image residuals, aiding in reconstructing high-resolution images with more detail.
- **Upsampling Technique**: Employs Conv2DTranspose layers within the generator to upscale images, achieving super-resolution.
- **Adversarial Training**: Utilizes a discriminator network, designed with Conv2D layers, to distinguish between real high-resolution images and super-resolved images generated by the network.
- **Perceptual Loss Calculation**: Leverages the VGG19 model to compute the perceptual loss, enhancing the textural quality of the super-resolved images.
- **Pixel Mixing for Training**: Introduces a novel approach to train the discriminator by mixing pixels from real and generated images, improving the model's ability to generalize.
- **Radiometric Analysis**: Offers tools for calculating and visualizing the radiometric difference between the original and enhanced images, providing quantitative feedback on the enhancement process.

## Prerequisites
To run NN.ipynb, ensure you have the following dependencies installed:
- TensorFlow => 4.8.0
- Keras => 2.15.0
- NumPy => 1.25.2
- Matplotlib => 3.7.1
- OpenCV => 4.8.0
- SKLearn => 1.2.2
- tqdm => 4.66.2

## Installation
Clone the repository to your local machine and navigate to the project directory. Ensure all dependencies listed in the `requirements.txt` file are installed.

Please note that NN.ipynb is the model with mixed pixels and the other is old model just trained with sentinel and planet scenes

## Usage Guide
1. **Prepare Your Dataset**: Organize your satellite images into separate directories for low-resolution (input) and high-resolution (target) images.
2. **Configure the Model**: Adjust the model's parameters, including the number of epochs, batch size(usually kept 1 for GAN models), and loss functions, as per your requirements.
3. **Train the Model**: Execute the training process. The script automatically divides the dataset into training and validation sets, and training progress can be monitored in real-time.
4. **Evaluate and Enhance**: Post-training, use the trained generator model to enhance low-resolution images. Evaluate the results using visual inspection and the provided radiometric difference calculation tool.

## Customizing Your Model

- Modify the number of residual blocks and the configuration of up-sampling layers in the generator to suit your specific enhancement needs.
- Adjust training parameters such as epochs and batch size based on your dataset size and computational resources.
- Fine-tune the image preprocessing steps to align with your image format and quality requirements.
- **Hyperparameter Tuning**: Consider implementing a hyperparameter optimization strategy, such as grid search or random search, to systematically explore different configurations of learning rates, decay factors, and other model parameters. This process can significantly impact the model's performance by identifying the optimal set of hyperparameters for your specific dataset and enhancement goals. Tools like Keras Tuner or Hyperopt can automate this process, saving time and improving model efficacy.

## Conclusion
NN.ipynb provides a comprehensive framework for applying GANs to the task of image super-resolution. By leveraging advanced neural network techniques and a novel pixel mixing strategy, it offers a powerful tool for enhancing image quality and resolution. Experiment with different configurations to achieve the best results for your specific application.

**Using Pre-trained Weights for Instant Super-Resolution**: After training, you can leverage the `gen_e_150.h5` file, which contains the generator's weights after 150 epochs of training, to enhance the resolution of your images without retraining. To apply these weights for super-resolution:

1. Ensure you have the `gen_e_150.h5` file in your project directory.
2. Load the pre-trained weights into your generator model using Keras functions. If you're using a custom generator architecture, make sure it matches the structure used during training before loading the weights.
3. Preprocess your low-resolution images to fit the input requirements of the model (e.g., resizing, normalization).
4. Use the generator to predict and obtain the super-resolved image from your low-resolution input.

Example code snippet for loading weights and predicting:

```python
scene_lr = cv2.imread("putlow_resolution_img.jpg")
scene_hr = cv2.imread("puthigh_resolution_img.jpg")

# Load the generator model
generator = load_model('/YOUR_PATH_TO_MODEL/gen_e_150.h5', compile=False)

#Change images from BGR to RGB for plotting.
#Remember that we used cv2 to load images which loads as BGR.
scene_lr = cv2.cvtColor(scene_lr, cv2.COLOR_BGR2RGB)
scene_hr = cv2.cvtColor(scene_hr, cv2.COLOR_BGR2RGB)

scene_lr = scene_lr / 255.
scene_hr = scene_hr / 255.

scene_lr = np.expand_dims(scene_lr, axis=0)
scene_hr = np.expand_dims(scene_hr, axis=0)

generated_scene_hr = generator.predict(scene_lr)

# plot all three images
plt.figure(figsize=(16, 8))
plt.subplot(231)
plt.title('planet Image')
plt.imshow(image_lr[0,:,:,:])
plt.subplot(232)
plt.title('Superresolution')
plt.imshow(generated_sreeni_hr[0,:,:,:])
plt.subplot(233)
plt.title('Sentinel image')
plt.imshow(sreeni_hr[0,:,:,:])

plt.show()
```

This step allows you to bypass the extensive training phase and directly enhance your images, making it a quick and efficient way to utilize the power of GANs for super-resolution tasks.

# Planet API Wrapper

## Overview
This notebook provides a Python wrapper planetapi.ipynb for interacting with the Planet API, designed to simplify the process of accessing and manipulating satellite imagery data.

## Features
- Authentication with the Planet API.
- Functions to search for satellite imagery based on specific criteria.
- Download capabilities for selected images.

## Requirements
- Python 3.x
- Requests library
- Any other necessary libraries (e.g., pandas, numpy, etc.)
- Account at Planet get the API key and paste in the notebook


# Sentinel API Wrapper

## Overview
This notebook serves as a Python wrapper sentinelAPI.ipynb(inside DataCollection) for the Sentinel satellite API, facilitating the access and analysis of Sentinel satellite data 

## Features
- Methods for authenticating with the Sentinel API.
- Functionality to search for satellite data based on parameters like location, date range, and cloud coverage.
- Download options for acquiring satellite images and data.

## Requirements
- Python 3.x
- Requests library for API calls.(Copy your own API key from Sentinel Hub)
- Libraries for data manipulation and visualization (e.g., pandas, numpy, matplotlib).
