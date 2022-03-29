# tutorial-advanced-track
Open Climate Data Science Workshop repository for the advanced track tutorial.

After this 2 hours tutorial you will: 

- *Define* open data and reproducible science in the context on your research 
- *Recognize* the importance of statistical analysis for climate data analysis using cloud based data.
- *Apply* techniques to access and explore via brief exploratory data analysis open source climate data from the cloud.
- *Create*  a machine learning model to predict results for a representative climate case study. 


## File Breakdown 

- images folder: where various images live to be included in knitted Binder Links and html files for tutorials
- .DS_Store, .RData, : Ignore these files - they are internal R files important for code complilation
- NCLIM2010.Rda: A .Rda file containing a singular data frame of the same name. This data is Coop Stations data for the 2010's across all US States and territories. This data houses 10 features:
    - date 
    - year
    - month 
    - day   
    - state: US State or terretory where re 
    - region_code: Somewhat irrelevant numeric variable, 1-1 corresponence with each state character variable.  
    - PRCP: recorded daily percipitation at the location in cm  
    - TAVG: recorded average tempurature (in deg C) throughout the course of the day
    - TMIN: recorded minimum tempurature atained (in deg C) throughout the course of the day  
    - TMAX: recorded maximum tempurature atained (in deg C) throughout the course of the day 
- NCLIM2020.Rda: Similar .Rda file containing a dataframe for the same variables from the same stations for the start of the 20's decade. Used for time series analysis over several days.  
