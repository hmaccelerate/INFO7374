# coding: utf-8

# <a href="https://colab.research.google.com/github/Rainniee/TextSummarization_PointerGenerator/blob/master/Chatbot%20Modeling_RNN%201.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>

# ### Load Tokenied Dataset

# In[1]:


'''Followed Adhira's binsss scripts, which generated story files and tokenized then wrote to bin
   I then converted the bin files to txt and made train.txt to article_abstract_tokenized.csv file
   The bin to txt scripts can be found in Convert BinaryFile to Text'''

# In[2]:


import pandas as pd

# dataset = pd.read_csv("article-abstract-tokenized.csv")
# dataset.head()

# ### Set Parameters

# In[3]:


from keras.models import Model
from keras.layers import Embedding, Dense, Input, RepeatVector, concatenate, Dropout
from keras.layers.recurrent import LSTM
from keras.preprocessing.sequence import pad_sequences
from collections import Counter
from sklearn.model_selection import train_test_split
from tensorflow.python.ops.rnn import dynamic_rnn
import numpy as np
import pandas as pd
import tensorflow as tf
import keras
from keras.models import load_model
from keras import backend as K

# In[4]:


RNN_SIZE = 128
BATCH_SIZE = 64
EPOCHS = 15
KEEP_PROBABILITY = 0.5
OPTIMIZER_TYPE = 'adam'
LEARNING_RATE = 0.001
EMBEDDING_SIZE = 100

data_dir_path = 'summarization/'
data_file = 'article-abstract-tokenized.csv'
glove_file = 'glove.6B.' + str(EMBEDDING_SIZE) + 'd.txt'
print(glove_file)

# In[5]:


VERBOSE = 1
NUM_LAYERS = 3
MAX_INPUT_SEQ_LENGTH = 500
MAX_TARGET_SEQ_LENGTH = 50
MAX_INPUT_VOCAB_SIZE = 3000
MAX_TARGET_VOCAB_SIZE = 1000
NUM_SAMPLES = 5000
MAX_DECODER_SEQ_LENGTH = 4


# In[6]:


def def_keras_optimizer():
    if OPTIMIZER_TYPE == 'sgd':
        # default LEARNING_RATE = 0.01
        keras_optimizer = keras.optimizers.SGD(lr=LEARNING_RATE, momentum=0.0, decay=0.0, nesterov=False)
    elif OPTIMIZER_TYPE == 'rmsprop':
        # default LEARNING_RATE = 0.001
        keras_optimizer = keras.optimizers.RMSprop(lr=LEARNING_RATE, rho=0.9, epsilon=None, decay=0.0)
    elif OPTIMIZER_TYPE == 'adagrad':
        # default LEARNING_RATE = 0.01
        keras_optimizer = keras.optimizers.Adagrad(lr=LEARNING_RATE, epsilon=None, decay=0.0)
    elif OPTIMIZER_TYPE == 'adadelta':
        # default LEARNING_RATE = 1.0
        keras_optimizer = keras.optimizers.Adadelta(lr=LEARNING_RATE, rho=0.95, epsilon=None, decay=0.0)
    else:  # OPTIMIZER_TYPE == 'adam':
        # default LEARNING_RATE = 0.001
        keras_optimizer = keras.optimizers.Adam(lr=LEARNING_RATE, beta_1=0.9, beta_2=0.999, epsilon=None, decay=0.0,
                                                amsgrad=False)

    return keras_optimizer


# In[7]:


def def_tf_optimizer(lr):
    if OPTIMIZER_TYPE == 'sgd':
        # default LEARNING_RATE = 0.01
        tf_optimizer = tf.train.GradientDescentOptimizer(lr)
    elif OPTIMIZER_TYPE == 'rmsprop':
        # default LEARNING_RATE = 0.001
        tf_optimizer = tf.train.RMSPropOptimizer(lr)
    elif OPTIMIZER_TYPE == 'adagrad':
        # default LEARNING_RATE = 0.01
        tf_optimizer = tf.train.AdagradOptimizer(lr)
    elif OPTIMIZER_TYPE == 'adadelta':
        # default LEARNING_RATE = 1.0
        tf_optimizer = tf.train.AdadeltaOptimizer(lr)
    else:  # OPTIMIZER_TYPE == 'adam':
        # default LEARNING_RATE = 0.001
        tf_optimizer = tf.train.AdamOptimizer(lr)

    return tf_optimizer


# ### Modeling

# In[8]:


def fit_text(x, y, input_seq_max_length=None, target_seq_max_length=None):
    if input_seq_max_length is None:
        input_seq_max_length = MAX_INPUT_SEQ_LENGTH
    if target_seq_max_length is None:
        target_seq_max_length = MAX_TARGET_SEQ_LENGTH
    input_counter = Counter()
    target_counter = Counter()
    max_input_seq_length = 0
    max_target_seq_length = 0

    for line in x:
        text = [word for word in line.split(' ')]
        for i, word in enumerate(text):
            if word == '':
                del text[i]
        seq_length = len(text)
        if seq_length > input_seq_max_length:
            text = text[0:input_seq_max_length]
            seq_length = len(text)
        for word in text:
            input_counter[word] += 1
        max_input_seq_length = max(max_input_seq_length, seq_length)

    for i, line in enumerate(y):

        line2 = 'START ' + str(line) + ' END'
        text = [word for word in line2.split(' ')]
        for j, word in enumerate(text):
            if word == '':
                del text[j]
        seq_length = len(text)
        if seq_length > target_seq_max_length:
            text = text[0:target_seq_max_length]
            seq_length = len(text)
        for word in text:
            target_counter[word] += 1
            max_target_seq_length = max(max_target_seq_length, seq_length)

    input_word2idx = dict()
    for idx, word in enumerate(input_counter.most_common(MAX_INPUT_VOCAB_SIZE)):
        input_word2idx[word[0]] = idx + 2
    input_word2idx['PAD'] = 0
    input_word2idx['UNK'] = 1
    input_idx2word = dict([(idx, word) for word, idx in input_word2idx.items()])

    target_word2idx = dict()
    for idx, word in enumerate(target_counter.most_common(MAX_TARGET_VOCAB_SIZE)):
        target_word2idx[word[0]] = idx + 1
    target_word2idx['UNK'] = 0

    target_idx2word = dict([(idx, word) for word, idx in target_word2idx.items()])

    num_input_tokens = len(input_word2idx)
    num_target_tokens = len(target_word2idx)

    config = dict()
    config['input_word2idx'] = input_word2idx
    config['input_idx2word'] = input_idx2word
    config['target_word2idx'] = target_word2idx
    config['target_idx2word'] = target_idx2word
    config['num_input_tokens'] = num_input_tokens
    config['num_target_tokens'] = num_target_tokens
    config['max_input_seq_length'] = max_input_seq_length
    config['max_target_seq_length'] = max_target_seq_length

    return config


# In[9]:


def transform_input_text(texts, input_word2idx, max_input_seq_length):
    temp = []
    for line in texts:
        x = []
        for word in line.lower().split(' '):
            wid = 1
            if word in input_word2idx:
                wid = input_word2idx[word]
            x.append(wid)
            if len(x) >= max_input_seq_length:
                break
        temp.append(x)
    temp = pad_sequences(temp, maxlen=max_input_seq_length)

    print(temp.shape)
    return temp


# In[10]:


def transform_target_encoding(texts, max_target_seq_length):
    temp = []
    for line in texts:
        x = []
        line2 = 'START ' + line.lower() + ' END'
        for word in line2.split(' '):
            x.append(word)
            if len(x) >= max_target_seq_length:
                break
        temp.append(x)

    temp = np.array(temp)
    print(temp.shape)
    return temp


# In[11]:


class RecursiveRNN(object):

    def __init__(self, config):
        self.num_input_tokens = config['num_input_tokens']
        self.max_input_seq_length = config['max_input_seq_length']
        self.num_target_tokens = config['num_target_tokens']
        self.max_target_seq_length = config['max_target_seq_length']
        self.input_word2idx = config['input_word2idx']
        self.input_idx2word = config['input_idx2word']
        self.target_word2idx = config['target_word2idx']
        self.target_idx2word = config['target_idx2word']
        self.config = config

        inputs1 = Input(shape=(self.max_input_seq_length,))
        am1 = Embedding(self.num_input_tokens, 128)(inputs1)
        am2 = LSTM(128)(am1)

        inputs2 = Input(shape=(self.max_target_seq_length,))
        sm1 = Embedding(self.num_target_tokens, 128)(inputs2)
        sm2 = LSTM(128)(sm1)

        decoder1 = concatenate([am2, sm2])
        outputs = Dense(self.num_target_tokens, activation='softmax')(decoder1)

        model = Model(inputs=[inputs1, inputs2], outputs=outputs)
        optimizer = def_keras_optimizer()
        model.compile(loss='categorical_crossentropy', optimizer=optimizer, metrics=['accuracy'])
        self.model = model

    def generate_batch(self, x_samples, y_samples, batch_size):
        encoder_input_data_batch = []
        decoder_input_data_batch = []
        decoder_target_data_batch = []
        line_idx = 0
        while True:
            for recordIdx in range(0, len(x_samples)):
                target_words = y_samples[recordIdx]
                x = x_samples[recordIdx]
                decoder_input_line = []

                for idx in range(0, len(target_words) - 1):
                    w2idx = 0  # default [UNK]
                    w = target_words[idx]
                    if w in self.target_word2idx:
                        w2idx = self.target_word2idx[w]
                    decoder_input_line = decoder_input_line + [w2idx]
                    decoder_target_label = np.zeros(self.num_target_tokens)
                    w2idx_next = 0
                    if target_words[idx + 1] in self.target_word2idx:
                        w2idx_next = self.target_word2idx[target_words[idx + 1]]
                    if w2idx_next != 0:
                        decoder_target_label[w2idx_next] = 1
                    decoder_input_data_batch.append(decoder_input_line)
                    encoder_input_data_batch.append(x)
                    decoder_target_data_batch.append(decoder_target_label)

                    line_idx += 1
                    if line_idx >= batch_size:
                        yield [pad_sequences(encoder_input_data_batch, self.max_input_seq_length),
                               pad_sequences(decoder_input_data_batch,
                                             self.max_target_seq_length)], np.array(decoder_target_data_batch)
                        line_idx = 0
                        encoder_input_data_batch = []
                        decoder_input_data_batch = []
                        decoder_target_data_batch = []

    def fit(self, x_train, y_train, x_test, y_test, epochs, batch_size):

        y_train = transform_target_encoding(y_train, self.max_target_seq_length)
        y_test = transform_target_encoding(y_test, self.max_target_seq_length)

        x_train = transform_input_text(x_train, self.input_word2idx, self.max_input_seq_length)
        x_test = transform_input_text(x_test, self.input_word2idx, self.max_input_seq_length)

        train_gen = self.generate_batch(x_train, y_train, batch_size)
        test_gen = self.generate_batch(x_test, y_test, batch_size)

        total_training_samples = sum([len(target_text) - 1 for target_text in y_train])
        total_testing_samples = sum([len(target_text) - 1 for target_text in y_test])
        train_num_batches = total_training_samples // batch_size
        test_num_batches = total_testing_samples // batch_size

        self.model.fit_generator(generator=train_gen, steps_per_epoch=train_num_batches, epochs=epochs, verbose=VERBOSE,
                                 validation_data=test_gen, validation_steps=test_num_batches)

    def summarize(self, input_text):
        input_seq = []
        input_wids = []
        for word in input_text.lower().split(' '):
            idx = 1  # default [UNK]
            if word in self.input_word2idx:
                idx = self.input_word2idx[word]
            input_wids.append(idx)
        input_seq.append(input_wids)
        input_seq = pad_sequences(input_seq, self.max_input_seq_length)
        start_token = self.target_word2idx['START']
        wid_list = [start_token]
        sum_input_seq = pad_sequences([wid_list], self.max_target_seq_length)
        terminated = False

        target_text = ''

        while not terminated:
            output_tokens = self.model.predict([input_seq, sum_input_seq])
            sample_token_idx = np.argmax(output_tokens[0, :])
            sample_word = self.target_idx2word[sample_token_idx]
            wid_list = wid_list + [sample_token_idx]

            if sample_word != 'START' and sample_word != 'END':
                target_text += ' ' + sample_word

            if sample_word == 'END' or len(wid_list) >= self.max_target_seq_length:
                terminated = True
            else:
                sum_input_seq = pad_sequences([wid_list], self.max_target_seq_length)

        return target_text.strip()


# In[23]:


def do_summarize(whole_content):
    # print ('loading csv file ...')
    df = pd.read_csv(data_dir_path + data_file)

    # print('extract configuration from input texts ...')
    y = df['abstract']
    x = df['article']
    config = fit_text(x, y)

    # print('configuration extracted from input texts ...')

    rnn_summarizer = RecursiveRNN(config)

    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42)

    # print('training size: ', len(x_train))
    # print('testing size: ', len(x_test))

    # print('start fitting ...')
    # rnn_summarizer.fit(x_train, y_train, x_test, y_test, epochs=EPOCHS, batch_size=BATCH_SIZE)
    # rnn_summarizer.model = load_model('summary_model.h5')
    rnn_summarizer.model = load_model('summarization/summary_model.h5')

    # print('start predicting ...')

    ####replace new_paragraph with file content
    abstract = rnn_summarizer.summarize(whole_content)
    K.clear_session()
    return abstract

# # Use example

# In[24]:
if __name__ == "__main__":
    whole_content="I don't know what to say but sounds interesting!"
    summary=do_summarize(whole_content)
    print(summary)

# whole_content="I don't know what to say but sounds interesting!"
# summary=do_summarize(whole_content)
# summary

