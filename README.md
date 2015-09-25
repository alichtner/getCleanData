---
title: "README"
author: "Aaron Lichtner"
date: "September 24, 2015"
output: html_document
---

This repo contains script "run_Analysis.R". As long as this script is in the root directory of the wearables dataset it will read in all required data and produce a clean data set called "dataClean".

The script works by reading in all required datasets. Testing and training data is combined via the rbind() and cbind() functions. A subset of this large dataframe is created using grepl() and searching for the keywords "mean" and "std" so that only columns with these words in them will be retained. The final clean dataset produced uses the aggregate() function to take the averages of each column grouped by the subject and activity that the subject was performing at the time. 
