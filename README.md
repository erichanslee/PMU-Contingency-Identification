Git Repository for Contingency Identification Routines. For older version, see https://github.com/ericlee0803/PowerGridsContig

Installation Requirements: 
MATLAB R2016+ 

# Folders:

## Workspace
* Contains scripts to generate contingency simulation data from PSAT. 
* If one wants to generate data themselves, requires PSAT to be installed and added (all directories and subdirectories) to the system path. See http://faraday1.ucd.ie/psat.html
* Most of Workspace NOT under version control due to large number and size of files`
 
## Routines 
* Contains contingency identification methods themselves. 
* (IMPORTANT) Run all tests with Routines set as current working directory to guarantee relative paths in scripts are correct. 
* For semi-thorough documentation, see Routines/doc/Contents.txt


## Python
* Python Scripts for Modal Domain Deomposition (02/2017: OUTDATED)

## Report
* Misc Reports 

# TO GENERATE AND USE DATA:
* Go to Workspace/57bus/
* Run runall.sh, a shell script generating time domain data of nonlinear and linear models, jacobians, etc. 
* Move matrixdata*, nonlinearbusdata*, linearbusdata* files to Routines/data/57bus/ in order to use for contingency identification
* Run scripts in Routines/doc/SampleScripts.m (don't run the entire thing it has a number of different scripts)


