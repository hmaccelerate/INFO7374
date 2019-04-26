# -*- coding: utf-8 -*-
"""
Created on Thu Apr 12 15:29:52 2019

@author: autpx
"""

#from __future__ import print_function
#from __future__ import division

def hardtok (data, highcut=True, maxf= 3, maxlen = 50, batch_size = 32, is_corpus=False):
    #import logging
    #logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO, filename='./output.log',)
    import sys, time
    import progressbar

    from collections import defaultdict
    from gensim import corpora, models, similarities, matutils
    #from pprint import pprint
    if type(data) !=  dict:
        raise ValueError('data is not a dict')
    doc = data['doc']

    import nltk
    from nltk.tokenize import word_tokenize
    
    total = 100
    pbar = progressbar.ProgressBar().start() ## pb
    # nltk tokenize
    texts = [word_tokenize(document) for document in doc]
    pbar.update(int((40 / (total - 1)) * 100)) ##pb
    
    # filter digits and punctuation
    texts = [[token.lower() for token in text if token.isalpha()] for text in texts]
    pbar.update(int((45 / (total - 1)) * 100)) ##pb
    
    # remove common words and tokenize
    # remove stop words
    from nltk.corpus import stopwords
    stop_w = stopwords.words('english')
    #print(stop_w)
    texts = [[token for token in text if token not in stop_w] for text in texts]
    #texts = [[lambda x:CleanLines(x) for x in text] for text in texts]
    pbar.update(int((50 / (total - 1)) * 100)) ##pb
    
    # stem of words
    from nltk.stem.porter import PorterStemmer
    porter = PorterStemmer()
    texts = [[porter.stem(word) for word in text] for text in texts]
    pbar.update(int((95 / (total - 1)) * 100)) ##pb
    
    frequency = defaultdict(int)
    for text in texts:
        for token in text:
           frequency[token] += 1
    if highcut:
        if is_corpus:
            texts = [[token for token in text if frequency[token] > 2] for text in texts]
        texts = [[token for token in text if frequency[token] < maxf*len(doc)] for text in texts]
    #pbar.update(int((99 / (total - 1)) * 100)) ##pb
    
    
    
    #cc = [dictionary.doc2idx(text) for text in texts]
    pbar.finish()
    
#    if trim:
#        corps=[]
#        for t in cc:
#            v = [-1]*maxlen
#            for i, w in enumerate(v):
#                w=t[i]
#            corps.append(v)
#        return corps
#    else:
    return texts

def w2vread (doclist, idx):
    import gensim
    a = len(doclist)
    b = len(idx)
    if a !=b:
        raise ValueError('data is not a dict')
    for i, v in enumerate(idx):
        yield gensim.models.doc2vec.TaggedDocument(doclist[i], [v])


def dictmaker (texts, **dictionary):
    from collections import defaultdict
    from gensim import corpora, models, similarities, matutils
    
    if dictionary:
        corps = [dictionary.doc2bow(text) for text in texts]
        return corps
    else:
        dictionary = corpora.Dictionary(texts)
        dictionary.save('./deerwester.dict')
        corps = [dictionary.doc2bow(text) for text in texts]
        
        return corps
   
def freqc (texts, p=False):
    from nltk.probability import FreqDist
    import matplotlib.pyplot as plt
    fdist = FreqDist()
    for text in texts:
        for token in text:
            fdist[token] += 1
    
    if p:
        plt.rcParams['figure.figsize'] = (12.0, 6.0) # 设置figure_size尺寸
        plt.rcParams['image.interpolation'] = 'nearest' # 设置 interpolation style
        plt.rcParams['image.cmap'] = 'gray' # 设置 颜色 style
        plt.rcParams['savefig.dpi'] = 300 #图片像素
        plt.rcParams['figure.dpi'] = 300 #分辨率
        
        fq_all = wfreq(texts)
        fq_all.plot(100, cumulative=False)
        
    return fdist



#print(dictionary)
#dictionary.num_docs
#dictionary.id2token
#dictionary.save('./deerwester.dict')
#dictionary = corpora.Dictionary.load("./deerwester.dict")
#corpus = [dictionary.doc2bow(text) for text in texts]
#corpora.MmCorpus.serialize('./deerwester.mm', corpus)
#corpus = corpora.MmCorpus('./deerwester.mm')




###############################################################################

if __name__ == "__main__":
    import json
    with open('./doc_model.json', 'rb') as f:
        raw = json.load(f)
        doc = raw['doc']
        lable = raw['lable']
        newdoc=hardtok(raw)
        
        freqc(newdoc)
        
        
        
        
        

#print(dictionary)
#import gensim
#dictionary = gensim.corpora.Dictionary.load("./bbc20n.dict")