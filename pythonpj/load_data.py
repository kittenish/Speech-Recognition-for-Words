# -*- coding: utf-8 -*-

import find_all_files as find
import read_cPickle as read
import numpy as np
import cPickle as p

def load_data(path) :
	labeldic = {'数字' : 0,'语音' : 1,'信号' : 2,'分析' : 3,'识别' : 4,'北京' : 5,'背景' : 6,\
	'上海' : 7,'商行' :8,'复旦' :9,'speech' :10,'voice' :11,'sound' :12,'happy' :13,\
	'lucky' :14,'file' :15,'open' :16,'close' :17,'start' :18,'stop' :19}
	files = find.find_all_files(path)
	data = np.empty((8473,116,24),dtype="float32")
	label = []
	for i in range(len(files)) :
		file_name = '/Users/mac/Desktop/pythonpj/traindata/' + files[i] 
		newdata = read.read_cPickle(file_name)
#		print i,newdata[:,:].shape, data[i,:,:].shape
		data[i,:,:] = newdata[:,:]
		strlist = files[i].split('_') 
		transstr = labeldic[strlist[1].lower()]
		label.append(transstr)
	print 'load finish'
	save_file = 'all_data.data'
	f = file(save_file, 'w')
	p.dump(data, f)
	f.close()
	save_file = 'all_label.data'
	f = file(save_file, 'w')
	p.dump(label, f)
	f.close()
	#return data,label

load_data('/Users/mac/Desktop/pythonpj/traindata')
