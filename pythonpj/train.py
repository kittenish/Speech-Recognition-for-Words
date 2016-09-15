from keras.models import Sequential
from keras.layers import LSTM, Dense,Dropout, Activation
from keras.utils import np_utils
from keras.regularizers import *
#import load_data as load
import read_cPickle as read
import numpy as np
import zeroize as z

#z.zeroize()


def build():
    global model
    data_dim = 24
    timesteps = 90
    model = Sequential()
    model.add(LSTM(timesteps, # return_sequences=True,
        batch_input_shape=(None, timesteps, data_dim), W_regularizer=l2(0.01)))
    model.add(Dropout(0.2))
    model.add(Dense(20, activation='softmax'))


    model.compile(loss='categorical_crossentropy',
            optimizer='rmsprop',
            metrics=["accuracy"])

def train(nb_epoch=30):
    f = model.fit(data,label,
            batch_size=64, nb_epoch=nb_epoch,
            show_accuracy=True,
            validation_split=0.1,
            shuffle=True)	
#    print f.history
    return f.history['val_loss'],f.history['val_acc']
build()

def save_model(nb_epoch):
    global data, label
    data = read.read_cPickle('/home/hs/Project/speech_recognition/pythonpj/miao/train_male_90.data')
    label = read.read_cPickle('/home/hs/Project/speech_recognition/pythonpj/miao/train_male_label_90.data')
    label = np_utils.to_categorical(label, 20)
    testdata = read.read_cPickle('/home/hs/Project/speech_recognition/pythonpj/miao/test_male_90.data')
    testlabel = read.read_cPickle('/home/hs/Project/speech_recognition/pythonpj/miao/test_male_label_90.data')
    minloss = 2.0
    minloss_acc = 0
    maxacc_loss = 0
    maxacc = 0.2
    for i in range(nb_epoch):
        loss,acc = train(1)
        #predict = model.predict(testdata, 64, 0)
        if loss[0] < minloss:
            minloss = loss[0]
            minloss_acc = acc[0]
            json_string = model.to_json()
            open('male_model_loss.json', 'w').write(json_string)
            model.save_weights('male_model_loss_weights.h5',overwrite=True)
        if acc[0] > maxacc:
            maxacc = acc[0]
            maxacc_loss = loss[0]
            json_string = model.to_json()
            open('male_model_acc.json','w').write(json_string)
            model.save_weights('male_model_acc_weights.h5',overwrite=True)
    print 'save maxacc :'
    print 'maxacc: %f, maxacc_loss: %f'%(maxacc,maxacc_loss)
    print 'save minloss :'
    print 'minloss: %f, minloss_acc: %f'%(minloss,minloss_acc)

#train(2)
save_model(200)
