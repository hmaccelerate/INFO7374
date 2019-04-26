# -*- coding: utf-8 -*-
"""
Created on Wed Apr 24 18:36:44 2019

@author: autpx
"""
def tagger (st):
    import numpy as np
    #import re
    #import sys
    #import pandas as pd
    #from os import path
    #from PIL import Image
    
    import gensim
    import os
    import collections
    import json
    
    import auto_tagging.hardtokenizer as ht
    
    with open('auto_tagging/words_frec.json', 'rb') as f:
        frequency = json.load(f)
    
    ss = {'doc':[st1]}
    line = ht.hardtok(ss)
    fc = ht.freqc(line)

    nf = dict()
    for key in set(line[0]):
        if key in frequency.keys():
        # d.iteritems: an iterator over the (key, value) items
            norm = float(fc[key])/(float(frequency[key])+1)
            nf[key] = norm
        else:
            nf[key] = 0
    
    nf.items()
    L = sorted(nf.items(),key=lambda item:item[1],reverse=True)
    
    res =[m[0] for m in L[:5]]
    string= ','
    enss = string.join(res)
    return enss

if __name__ == "__main__":
    st1 = "quake's economic costs emergingasian governments and international agencies are reeling at the potential economic devastation left by the asian tsunami and floods.world bank president james wolfensohn has said his agency is \"only beginning to grasp the magnitude of the disaster\" and its economic impact. the tragedy has left at least 25,000 people dead, with sri lanka, thailand, india and indonesia worst hit. some early estimates of reconstruction costs are starting to emerge. millions have been left homeless, while businesses and infrastructure have been washed away.economists believe several of the 10 countries hit by the giant waves could see"
    print(tagger(st1))
    
    
    
    
    
    
    
    
    
    
    
    
