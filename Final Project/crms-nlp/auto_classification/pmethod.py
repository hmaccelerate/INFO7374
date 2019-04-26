#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 23 17:09:54 2019

@author: autumnbreed
"""
import gensim


def predict (st):
    import numpy as np
    #import re
    #import sys
    #import pandas as pd
    #from os import path
    #from PIL import Image
    
    # local functions
    import auto_classification.hardtokenizer as ht
    ss = {'doc':[st]}
    
    newdoc=ht.hardtok(ss)
    model = gensim.models.doc2vec.Doc2Vec.load('auto_classification/w2v_model')
    
    def embb (texts, model):
        import progressbar
        pbar = progressbar.ProgressBar().start()
        dvec = []
        total= len(texts)+2
        for i, t in enumerate(texts):
            dvec.append(model.infer_vector(t))
            pbar.update(int((i / (total - 1)) * 100))
        pbar.finish()
        return dvec
    
    docvec1 = embb(newdoc, model)
    dv = docvec1[0].reshape(1,50)
    #doc_mat = np.concatenate(docvec1, axis=0).reshape(len(docvec1),50)
    
    from keras.models import Sequential
    from keras.layers import Dense, Dropout, Activation, Flatten
    from keras import regularizers
    from keras import optimizers
    from keras import backend as K
    from keras.models import load_model
    main_model = load_model('auto_classification/my_model.h5')
    
    ynew = main_model.predict_classes(dv)
    K.clear_session()
    indexd ={6:'business',0:'entertainment',3:'politics',4:'religion',1:'sci',2:'sport',5:'tech'}
    la = indexd[ynew[0]]
    return la
    
############################################################################### 
    
if __name__ == "__main__":
    st = "quake's economic costs emergingasian governments and international agencies are reeling at the potential economic devastation left by the asian tsunami and floods.world bank president james wolfensohn has said his agency is \"only beginning to grasp the magnitude of the disaster\" and its economic impact. the tragedy has left at least 25,000 people dead, with sri lanka, thailand, india and indonesia worst hit. some early estimates of reconstruction costs are starting to emerge. millions have been left homeless, while businesses and infrastructure have been washed away.economists believe several of the 10 countries hit by the giant waves could see"
    rel=predict(st)
    print(rel)
    
    
#from sklearn.datasets.samples_generator import make_blobs
#from sklearn.preprocessing import MinMaxScaler
#    
#Xnew, _ = make_blobs(n_samples=3, centers=2, n_features=2, random_state=1)
#Xnew = scalar.transform(Xnew)

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



























