#coding:UTF-8
import scipy.io as scio
def read_mat(datafile) :
    data = scio.loadmat(datafile)
    return data['after_mfcc']

