#!/bin/bash

# Set environment name and repository
ENV_NAME="sysid_env"

echo "Creating Conda environment..."
conda create -n $ENV_NAME python=3.9 -y

# Step 2: Activate the environment
echo "Activating the environment..."
source activate $ENV_NAME
conda install ipykernel -y
python -m ipykernel install --user --name=$ENV_NAME
conda install -c conda-forge slycot -y
conda install -c conda-forge statsmodels -y

#pip install --no-cache-dir slycot

echo "Installing dependencies..."
pip install --no-cache-dir -r requirements.txt

echo "Installing SIPPY..."
python setup.py install 