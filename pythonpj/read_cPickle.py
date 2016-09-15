import cPickle as p

def read_cPickle(path) :
	f = file(path)
	data = p.load(f)
	#print data.shape[0]
	return data

#read_cPickle('/Users/mac/Desktop/pythonpj/traindata/11307120032_Sound_05.data')
