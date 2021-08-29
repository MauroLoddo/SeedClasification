# -*- coding: utf-8 -*-

import pandas as pd
import glob
import os

def getLabelFromFilename(filename):
    label = os.path.basename(filename)
    label = label.split('_')[0]    
    
    return label

csvFiles = glob.glob('C:/Users/loand/Documents/GitHub/Tesisti/SeedClasification/classification/Cagliari/*_All.csv')

df = pd.read_csv(csvFiles[0])
label = getLabelFromFilename(csvFiles[0])

finalCsv = df
#finalCsv['Label'] = finalCsv['Label'].apply(lambda x: label)
finalCsv = finalCsv.replace(to_replace ="Test", value = label) 


for csv in csvFiles[1:]:

    csvDf = pd.read_csv(csv)    
    label = getLabelFromFilename(csv)
    csvDf = csvDf.replace(to_replace ="Test", value = label) 
  
    finalCsv = finalCsv.append(csvDf, ignore_index=True)

finalCsv.to_csv('Features.csv', index=False)