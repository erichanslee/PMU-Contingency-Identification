
# genfiles.sh simply touches the contingency files needed for matlab
./genfiles.sh

# Generate Contingency Files via PSAT
matlab -nosplash -nodesktop -nodesktop < gen_contigfiles.m

# Run PSAT 	simulations
matlab -nosplash -nodesktop -nodesktop < psat_runtrials.m

# Prune full PSAT data to generate Jacobian Matrices and Bus Data
matlab -nosplash -nodesktop -nodesktop < prune_datafiles.m
