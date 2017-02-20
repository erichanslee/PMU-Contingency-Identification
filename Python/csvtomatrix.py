import numpy as np
# csvtomatrix just takes a csv (a matrix stored in a csv file) and returns a numpy array. 

def csvtomatrix(filename):
	matrix = np.loadtxt(open(filename, "rb"), delimiter=",", skiprows=0)
	return matrix


