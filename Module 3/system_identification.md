# Data Driven Modelling and System Identification. 

In today's afternoon session, you will learn how to identify a system purely from measured data.

### Setup the Environment and Install Requirements
The library dependencies we will be using are tricky, especially the one from SIPPY. So, I have created an automated .bash file named **install.sh** in the SIPPY folder. This file will create a new conda environment named *sysid_env* and handle all the dependencies and installation needed.

```bash
cd SIPPY
sudo bash install.sh
```
However, in the case, you get some error in the building phase, don't panic, you can always use old good habits, i.e.

You have three library options to complete the exercise. So if one library fails to install, you can use one of the other two. 

**!!!DO THIS ONLY IS THE BASH INSTALLATION FAILED!!!**

Open your terminal and run the following command:

```bash
#create a new conda environment
conda create -n sysid_env python=3.xx
#activate your environment 
conda activate sysid_env
# install jupyter extension
conda install jupyter
# install ipykernel extension
conda install ipykernel
# install pip extension
conda install pip
# Finally, install the libraries needed for this module (the one in the sippy folder)
pip install -r requirements.txt
```
Again, if the installation fails for some package, please remove it from the requirements.txt file and do it manually. 


### Learn how to fit ARX (but not only...) models. 
If the setup of the environment is complete and everything is working correctly, it is time to start modeling. 
To start with: 

- Open the fit_arx_model.ipynb and order_selection_AIC_BIC.ipynb notebooks, and press the button **Run All**. Check again if everything runs without errors.

Now, you are ready to familiarize yourself with the fitting processes. Open the file **fit_arx_model.ipynb** and learn how an ARX model is structured and how you can fit models directly from data. 

To this end, three different libraries are available. I would appreciate it if could spend some time understanding how they work and differ from each other. The **SIPPY** library is more specialized in system identification for control, while **GEKKO** is for parameter identification and control, and **SysIdentipy** is great for fitting models using different estimators. **SysIdentipy** is very easy to use and has *.fit* and *.predict* methods. 
So if you are more interested in embedded control, my suggestion is to explore **SIPPY**. If you just want to survive the day, go for **SysIdentipy** :)


Be sure to learn the code, and give yourself the time to break, fix, and break the code again. 


### Learn to fit data from a real energy asset. 
The previous part is fun, isn't it? :) 
But I think that now that you have learned how to fit models, you should challenge yourself a bit more and try to estimate something more complex. 
Therefore: 

- Open the file *pump_station_data.parquet* from the data folder.
You can use the following code: 

```python
import pandas as pd

data = pd.read_parquet("data/pump_station_data.parquet")
```

- Resample the data index from seconds to minutes. This will help to stabilize the variance and make the fit more stable. 

```python
import pandas as pd

data = data.resample("1min").mean()
```
Once resampled the data, 

- Select a portion of the data(a  couple of days would be enough) 
- Fit your model using *pump1_power* or respectively *pump4_power* as function of *pump1_rpm* or *pump4_rpm* (use onyl one of the proposed libraries). 
- Predict the model on unseen data.
- Check the error of your model.

```python
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import mean_squared_error
from sysidentpy.metrics import root_relative_squared_error

#you can use sklearn.metrics to compute mae, mse and rmse.
mae  = ...
mse  = ...
rmse = ...
```

- Plot the residuals and verify if they are distributed as white noise.  
In today's lesson, we defined the residuals as the portion of the validation data not explained by the model and assumed the so-called *whiteness condition*, which states that the model's error follows a normal distribution $\epsilon(t) \sim \mathcal{N}(0,\sigma^2) $, with:
$\epsilon_t = y_t - \hat{y}_t$

##### Use an histogram to plot the residuals of your model. Can you quantify the $\sigma^2$.
```python
import matplotlib.pyplot as plt

residuals = your_data - yhat

# Plotting the histogram of residuals
plt.hist(residuals, bins=20, edgecolor='black')
plt.xlabel('Residuals')
plt.ylabel('Frequency')
plt.title('Histogram of Residuals')
plt.show()
```



