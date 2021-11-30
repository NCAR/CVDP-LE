# CVDP-LE
The Climate Variability Diagnostics Package for Large Ensembles (CVDP-LE) developed by NCAR's Climate Analysis Section is an automated analysis tool and data repository for exploring internal and forced contributions to climate variability and change in coupled model “initial-condition” Large Ensembles and observations.

The package computes a wide range of modes of interannual-to-multidecadal variability in the atmosphere, ocean and cryosphere, as well as long-term trends and key indices of global and regional climate. Diagnostics include the ensemble-mean (i.e., forced response) and ensemble-spread (i.e., internal variability) of each model, as well as quantitative metrics comparing the models to observations. All diagnostics and metrics are saved to a data repository for later use and analysis.

CVDP-LE example comparison:<br>
<a href="http://webext.cgd.ucar.edu/Multi-Case/CVDP-LE_repository/CMIP6_Historical_1900-2014/">CMIP6 Historical 1900-2014</a>

The CVDP-LE is the successor to the <a href="https://github.com/NCAR/CVDP-ncl">CVDP</a>. Note that while many of the individual simulation metrics are similar between the CVDP and CVDP-LE, the CVDP-LE has a focus on ensemble metrics. 

# Getting Started
View the <a href="https://github.com/NCAR/CVDP-LE/blob/master/CVDP-LE_readme_1.0.0.pdf">readme file</a> for details on how to run the CVDP-LE. The <a href="http://dx.doi.org/10.5065/h7c7-f961">CVDP-LE User’s Guide</a> provides general background on initial-condition Large Ensembles, detailed documentation of 
all diagnostics and metrics in the package, and guidance on interpreting the results.

# Input data
The CVDP-LE can read in the following data types as input:
- CMIP6
- CMIP5
- CMIP3
- CSM, CCSM and CESM
- Observations with file names and data array names matching CMIP conventions.

# Getting help
If the <a href="https://github.com/NCAR/CVDP-LE/blob/master/CVDP-LE_readme_1.0.0.pdf">readme file</a>, the <a href="http://dx.doi.org/10.5065/h7c7-f961">CVDP-LE User’s Guide</a> or the <a href="https://www.cesm.ucar.edu/working_groups/CVC/cvdp-le/">CVDP-LE website</a> do not answer your query or if you have a bug report or suggestion, it is recommended that you <a href="https://github.com/NCAR/CVDP-LE/issues">open an issue on Github</a>. 
