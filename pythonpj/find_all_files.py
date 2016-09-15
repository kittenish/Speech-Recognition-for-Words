import os

def find_all_files(path) :
	files = []
	for name in os.listdir(path):
		if os.path.isfile(os.path.join(path, name)):
			if name != '.DS_Store' and name!= '.' and name != '..' :
				files.append(name)
	return files
