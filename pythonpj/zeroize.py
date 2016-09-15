import find_all_files as find
import read_mat as read
import numpy as np
import cPickle as p

def find_max_size(path) :
	files = find.find_all_files(path)
	length = 116
#	print files[0]
#	for i in range(len(files)) :
#		file_name = '/Users/mac/Desktop/pj/testmat/' + files[i] 
#		data = read.read_mat(file_name)
#		length = max(length, data.shape[0])
	return files,length

def zeroize() :
    #files,length = find_max_size('/home/hs/Project/speech_recognition/trainmat')
	files,length = find_max_size('/Users/mac/Desktop/pj/testmat')
	print length
	for i in range(len(files)) :
		file_name = '/Users/mac/Desktop/pj/testmat/' + files[i]
		data = read.read_mat(file_name)
		z_data = np.zeros([length,24])
		data_len = data.shape[0]
		z_data[0:data_len - 1,:] = data[0:data_len - 1,:]
		save_file = files[i][0:len(files[i]) - 4] + '.data'
		f = file(save_file, 'w')
		p.dump(z_data, f)
		f.close()

