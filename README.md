# tutorial-advanced-track

Open Climate Data Science Workshop repository for the advanced track tutorial.

Created by  [Nick Gawron](https://www.linkedin.com/in/ngawrondata/) and [Livia Popa](https://www.linkedin.com/in/livia-popa-23a018183/) for the 
Open Climate Data Science Workshop hosted by the North Carolina State Climate Office in partnership with the North Carolina Institute for Climate Studies.


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
- advanced_tutorial.Rmd: R Markdown file used as basis for advanced tutorial. Openable in R Studio and analogous to binder teacher version (mentioned below). 
- advanced_tutorial.html: HTML output file of the .Rmd file with all solutions and code blocks. Similar to teacher version. Not editable but interactive with page buttons. 
- advanced_tutorial_student.ipynb: Binder Notebook file with empty code blocks used for tutorial purposed and live coding. Outputs not included. Runs in R kernel.
- advanced_tutorial_teacher.ipynb: Binder Notebook file with filled out with solutions and ouput plots and models to advanced tutorial. Runs in R kernel.
- cardinal_data.csv: CSV of ECONet Station Data used for PCA Bonus Section


## Binder Information 

If you wish to see the tutorials as presented in the Open Climate Data Science Workshop please visting the tutorial page of the [website](https://open-climate-data-science.github.io/tutorials/). Here you will find two links for the Beginner Track:
    -  Student: A notebook with incomplete code blocks that was accessed by partipants
    -  Teacher: A helpful reference guide with completed code from the tutorial
   
Please note a recording of the tutorial is also attached on the referenced website page. 
