# runDMD runs Dynamic Mode Decomposition on some time domain data using DMDpack
# (see https://github.com/Benli11/DMDpack for more information)
# 
# INPUTS
# data = time domain data
# timestep = size of signal
# 
# 
# OUTPUTS
# Empirical Eigenvectors and Eigenvalues, saved in 
# eigvec.csv and eigval.csv respectively (in a non-sparse format)


import dmd as dmd