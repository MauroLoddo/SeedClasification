# -*- coding: utf-8 -*-

import pandas as pd 
import glob

csvFiles = glob.glob('C:/Users/loand/Downloads/IJCNN/*.csv')

df1 = pd.read_csv(csvFiles[0], compression='gzip' )
