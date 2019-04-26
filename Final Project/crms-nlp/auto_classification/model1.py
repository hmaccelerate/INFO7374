# -*- coding: utf-8 -*-
"""
Created on Tue Apr 13 22:19:08 2019

@author: autpx
"""

from __future__ import print_function
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
#import re
#import sys
#import pandas as pd
#from os import path
#from PIL import Image

import gensim
import os
import collections
import smart_open
import random

# local functions
import auto_classification.hardtokenizer as ht
# hardtok, w2vread, dictmaker, freqc

import logging
logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO, filename='./output.log',)
# doc to vec

import json
with open('./doc_model.json', 'rb') as f:
    raw = json.load(f)
    doc = raw['doc']
    lable = raw['lable']
    idx = raw['id']
    
    
newdoc=ht.hardtok(raw)
ht.freqc(newdoc)


train_corpus = list(ht.w2vread(newdoc,idx))

train_corpus[:2]

model = gensim.models.doc2vec.Doc2Vec(vector_size=50, min_count=2, epochs=40)


model.build_vocab(train_corpus)

import time
model.train(train_corpus, total_examples=model.corpus_count, epochs=model.epochs)

model.infer_vector(['only', 'you', 'can', 'prevent', 'forest', 'fires'])

model.save('./w2v_model')
model = gensim.models.doc2vec.Doc2Vec.load('./w2v_model')

def embb (texts, model):
    import progressbar
    pbar = progressbar.ProgressBar().start()
    dvec = []
    total= len(texts)
    for i, t in enumerate(texts):
        dvec.append(model.infer_vector(t))
        pbar.update(int((i / (total - 1)) * 100))
    pbar.finish()
    return dvec

docvec1 = embb(newdoc, model)

doc_mat = np.concatenate(docvec1, axis=0).reshape(17211,50)

###############################################################################
# target data
keys = set(lable)
values = list(range(0,len(keys)))
c_dict = dict(zip(keys, values))
rep = [c_dict[x] if x in c_dict else 7 for x in lable]

from keras.utils import to_categorical
encoded=to_categorical(rep)
print(encoded)

#import sklearn
from sklearn.model_selection import train_test_split

#x为数据集的feature熟悉，y为label.
x_train, x_test, y_train, y_test = train_test_split(doc_mat, encoded, test_size = 0.2)

###############################################################################
# model

def para_test(bsize, nlay, deep, lr, ActFun, DropRate, ep):
    import keras
    from keras import backend as K
    from keras.models import Sequential
    from keras.layers import Dense, Dropout, Activation, Flatten
    from keras import regularizers
    from keras import optimizers
    inputs=50
    num_classes = 7
    model = Sequential()
    model.add(Dense(nlay, activation=ActFun, input_shape=(inputs,)))
    model.add(Dropout(DropRate))
    if deep:
        model.add(Dense(nlay, activation=ActFun))
        model.add(Dropout(DropRate))
    
    model.add(Dense(num_classes, activation='softmax'))
    
    sgd = optimizers.SGD(lr=lr)
    model.compile(optimizer=sgd,
                loss='categorical_crossentropy',
                metrics=['accuracy'])
    model.fit(x_train, y_train, epochs=ep, batch_size = bsize)
    return (model)

mb = para_test(bsize=32, nlay=20, deep=False, lr=0.05, ActFun='relu', DropRate=0.25, ep=50)

def show_r(model):
    
    test_loss, test_acc = model.evaluate(x_test, y_test)
    print('test_acc:', test_acc)

    history = model.history
    #history_dict = history.history

    acc = history.history['acc']
    print('train acc:', acc[-1])
    #val_acc = history.history['val_acc']
    loss = history.history['loss']
    #val_loss = history.history['val_loss']

    epochs = range(1, len(acc) + 1)

    # "bo" is for "blue dot"
    plt.plot(epochs, loss, 'bo', label='Training loss')
    # b is for "solid blue line"
    #plt.plot(epochs, val_loss, 'b', label='Validation loss')
    plt.title('Training loss')
    plt.xlabel('Epochs')
    plt.ylabel('Loss')
    plt.legend()

    plt.show()

    plt.plot(epochs, acc, 'go', label='Training acc')
    # b is for "solid blue line"
    #plt.plot(epochs, val_acc, 'g', label='Validation loss')
    plt.title('Training acc')
    plt.xlabel('Epochs')
    plt.ylabel('acc')
    plt.legend()

    plt.show()

show_r(mb)

###############################################################################
from keras.models import load_model
 
mb.save('./my_model.h5')

main_model = load_model('./my_model.h5')


















