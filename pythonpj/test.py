from keras.models import Sequential
import read_cPickle as read
import numpy as np
from keras.models import model_from_json

def test():
    testdata = read.read_cPickle('/home/hs/Project/speech_recognition/pythonpj/miao/test_female_100.data')
    testlabel = read.read_cPickle('/home/hs/Project/speech_recognition/pythonpj/miao/test_female_label_100.data')
    model = model_from_json(open('female_model_acc.json').read())
    model.load_weights('female_model_acc_weights.h5')
    predict = model.predict(testdata,64,0)
    right = 0
    for i in range(271):
        ans = np.where(predict[i,:] == np.amax(predict[i,:]))
        if ans[0][0] == testlabel[i]:
            right = right + 1
    print 'predict right: %d'%(right)
    print 'predict accuracy: %f'%(right/271.0)
test()
