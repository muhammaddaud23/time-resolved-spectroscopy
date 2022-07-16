# time-resolved-spectroscopy
This repo shows codes to execute rxte burst data reduction automation from Heasoft

The codes are built based on Event-mode spectral data reduction https://heasarc.gsfc.nasa.gov/docs/xte/recipes/pca_event_spectra.html.
The create response matrices step is not included here since i've got some issues with memory in Heasoft 6.28. But, i could still create them in Heasoft 6.19 in another machine.
The codes only work for 1 obs-id file in each running. But, there are some potential to upgrade this.
The parameter which was set in the code was based on my needs. If you want to change the parameter, please read the code carefully first.

For instruction on how to run the code, please read the procedure.txt

Example of the final result from this automation code can be seen here [a paper](https://www.as.itb.ac.id/astroedu70/wp-content/uploads/sites/12/2022/05/Prosiding_SPA2021_Daud_dan_Vierdayanti.pdf) 
