---
title: "CodeBook"
author: "PW"
date: '2022-07-08'
output: html_document
---


## R Markdown

# run_analysis.R


## variables

-data       : combined train and test observations
-labels     : combined labels for train and test observations
-subjects   : combined list of subjects from train and test observations
-activity   : maps activity code and text label
-cols      : list of with appropriate names
-colnames  : keeps the column names and give descriptive names to each feature
-set   : contains total set of observations combined with activity labels and subject numbers
-averages : stores the final result grouped by activity and subject with average value of all features for each group.

## transforming the data
-the grep() function to captures column numbers and column names that contains "mean" or "std" in its description. 
-use gsub() function to replace "()" and "-" from the text 
-"data" with all features is filtered based on the given columns for mean and std values. 
-"labels" integer values are transformed to text by doing a lookup of values of "labels" into "activity" dataframe
-"set" is column bind of observations, activity labels and subject numbers
-name of columns in set are replaced by "column_names"
-averages is obtained with the pipeline of the functions groupby() and summarize_all()
  

