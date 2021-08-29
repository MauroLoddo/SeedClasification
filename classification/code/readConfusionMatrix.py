# -*- coding: utf-8 -*-
"""
Created on Fri Mar 26 19:42:01 2021

@author: loand
"""

from scipy.io import savemat
import numpy as np
import os
import glob

def convertWeka2MatConfusionMatrix(inputFilename, outputFilename):
    file = open(inputFilename, "r")
    lines = file.readlines()
    lastline = lines[-1]
    lines = lines[:-1]
    
    cm = '[ '
    
    for x in lines:
        x = x.split("| ")[0]
        cm = cm + x + ';'
            
    closing = lastline.split("| ")[0]
    cm = cm + closing + ']'
    file.close()
    
    cm = np.matrix(cm)
    mdic = {"cm": cm}
    savemat(outputFilename, mdic)
    
    
classifiers = ['Bayes', 'kNN', 'SVM', 'RF']

#mainFolder = 'C:\\Users\\loand\\Documents\\GitHub\\Tesisti\\SeedClasification\\classification\\Cagliari\\Results\\'
mainFolder = 'C:\\Users\\loand\\Documents\\GitHub\\Tesisti\\SeedClasification\\classification\\Cagliari\\Results\\Test'
CM = 'CM'
Weka = 'Weka'

for c in classifiers:
    files = glob.glob( os.path.join( mainFolder, c, Weka, '*.txt' ) )
    for f in files:
        outname = f.split('\\')[-1]
        outname = outname.split('.')[0] + '.mat'
        outputFilename = os.path.join( mainFolder, c, CM, outname )
        print(outputFilename)
        convertWeka2MatConfusionMatrix(f, outputFilename)