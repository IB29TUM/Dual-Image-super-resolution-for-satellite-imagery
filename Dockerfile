# Use the official Python image as the base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container's working directory
COPY NN.py /app/NN.py

# Copy the image folders into the container
COPY hr_images /app/hr_images
COPY augmented_images /app/augmented_images

# Install necessary dependencies
RUN apt-get update \
    && apt-get install -y libgl1-mesa-glx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install opencv-python matplotlib keras tensorflow scikit-learn tqdm

# Expose any ports needed (if your script runs on a server)
# EXPOSE <port_number>

# Set the command to run your Python script
CMD ["python", "NN.py"]
