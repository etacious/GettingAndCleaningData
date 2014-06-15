Course Project - Getting and Cleaning Data
========================================================

## Markdown file for run_analysis.R

Note that this function below includes the meanFreq() measurements, not just mean(). 

```
feat_ismean <- sapply(feat$V2,function(x) grepl("mean",x))
```

However, meanFreq was excluded so as to keep consistency with the type of mean being calculated for all measurements 

```
feat_isfreqmean <- sapply(feat$V2,function(x) grepl("meanFreq",x))
#all selected measurment fields, excluding meanFreq
feat_sel <- (feat_ismean & ! feat_isfreqmean)  | feat_isstd
```
#new line
#another new line