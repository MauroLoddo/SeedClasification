# -*- coding: utf-8 -*-

import pandas as pd 
import glob

dataset = 'Canada' # 'Cagliari'

csvFiles = glob.glob('C:/Users/loand/Documents/GitHub/Tesisti/SeedClasification/classification/'+dataset+'/Features/*.csv')
folderFeature = '../' + dataset + '/Features/ByDescriptor/'

df = pd.read_csv( csvFiles[0] )



if dataset == 'Canada':
    label = df.iloc[0:, 7]
    
    df.drop('Label', inplace=True, axis=1)

    df_bw = df.iloc[0:, 1:32]
    df_gray = df.iloc[0:, 32:47]
    df_rgb = df.iloc[0:, 47:]
    
elif dataset == 'Cagliari':
    df_bw = df.iloc[0:, 1:33]
    df_gray = df.iloc[0:, 33:48]
    df_rgb = df.iloc[0:, 48:]
    

df_bw_gray = pd.concat( [df_bw, df_gray, label], axis=1 )
df_bw_rgb = pd.concat( [df_bw, df_rgb, label], axis=1 )
df_gray_rgb = pd.concat( [df_gray, df_rgb, label], axis=1 )

df_bw = pd.concat( [df_bw, label], axis=1 )
df_gray = pd.concat( [df_gray, label], axis=1 )
df_rgb = pd.concat( [df_rgb, label], axis=1 )

df_bw.to_csv(folderFeature+'FeaturesBW.csv', index=False)
df_gray.to_csv(folderFeature+'FeaturesGray.csv', index=False)
df_rgb.to_csv(folderFeature+'FeaturesRGB.csv', index=False)

df_bw_gray.to_csv(folderFeature+'FeaturesBW_Gray.csv', index=False)
df_bw_rgb.to_csv(folderFeature+'FeaturesBW_RGB.csv', index=False)
df_gray_rgb.to_csv(folderFeature+'FeaturesGray_RGB.csv', index=False)