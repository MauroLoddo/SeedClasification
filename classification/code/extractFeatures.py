# -*- coding: utf-8 -*-

import pandas as pd 
import glob

csvFiles = glob.glob('C:/Users/loand/Documents/GitHub/Tesisti/SeedClasification/classification/Cagliari/Features/*.csv')

df = pd.read_csv( csvFiles[0] )

df_bw = df.iloc[0:, 1:33]
df_gray = df.iloc[0:, 33:48]
df_rgb = df.iloc[0:, 48:]

df_bw_gray = pd.concat( [df_bw, df_gray], axis=1 )
df_bw_rgb = pd.concat( [df_bw, df_rgb], axis=1 )
df_gray_rgb = pd.concat( [df_gray, df_rgb], axis=1 )

df_bw_gray['Label'] = df['Label']

#df_bw.to_csv('../Cagliari/Features/ByDescriptor/FeaturesBW.csv', index=False)
#df_gray.to_csv('../Cagliari/Features/ByDescriptor/FeaturesGray.csv', index=False)
#df_rgb.to_csv('../Cagliari/Features/ByDescriptor/FeaturesRGB.csv', index=False)

df_bw_gray.to_csv('../Cagliari/Features/ByDescriptor/FeaturesBW_Gray.csv', index=False)
df_bw_rgb.to_csv('../Cagliari/Features/ByDescriptor/FeaturesBW_RGB.csv', index=False)
df_gray_rgb.to_csv('../Cagliari/Features/ByDescriptor/FeaturesGray_RGB.csv', index=False)